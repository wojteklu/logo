protocol Node: CustomStringConvertible {}
protocol Statement: Node {}
protocol Expression: Node {}

enum Precedence: Int {
    case lowest
    case equals
    case lessgreater
    case sum
    case product
    case prefix
    case call
}

final class Parser {
    private let lexer: Lexer
    private var curToken: Token
    private var nextToken: Token
    private var prefixFunction: [TokenType: (() -> Expression)] = [:]
    private var infixFunction: [TokenType: ((Expression) -> Expression)] = [:]
    var errors: [String] = []

    private let precedences: [TokenType: Precedence] = [
        .equal: .equals,
        .not_equal: .equals,
        .lt: .lessgreater,
        .gt: .lessgreater,
        .plus: .sum,
        .minus: .sum,
        .slash: .product,
        .asterisk: .product,
        .lParen: .call
    ]
    
    init(lexer: Lexer) {
        self.lexer = lexer
        self.curToken = lexer.nextToken()
        self.nextToken = lexer.nextToken()
        
        prefixFunction[.identifier] = parseIdentifier
        prefixFunction[.variable] = parseVariable
        prefixFunction[.if] = parseIfExpression
        prefixFunction[.to] = parseFunctionLiteral
        prefixFunction[.repeat] = parseRepeatExpression
        prefixFunction[.true] = parseBoolean
        prefixFunction[.false] = parseBoolean
        prefixFunction[.Number] = parseNumber
        prefixFunction[.minus] = parsePrefixExpression
        prefixFunction[.lParen] = parseGroupedExpression
        
        infixFunction[.plus] = parseInfixExpression
        infixFunction[.minus] = parseInfixExpression
        infixFunction[.slash] = parseInfixExpression
        infixFunction[.asterisk] = parseInfixExpression
        infixFunction[.equal] = parseInfixExpression
        infixFunction[.not_equal] = parseInfixExpression
        infixFunction[.lt] = parseInfixExpression
        infixFunction[.gt] = parseInfixExpression
        infixFunction[.lParen] = parseCallExpression
    }
    
    func parse() -> Program {
        var statements: [Statement] = []
        
        while curToken.type != .eof {
            statements.append(parseStatement())
            advance()
        }
        
        return Program(statements: statements)
    }
    
    private func advance() {
        curToken = nextToken
        nextToken = lexer.nextToken()
    }
    
    private var nextPrecedence: Precedence {
        return precedences[nextToken.type] ?? .lowest
    }
    
    private var currentPrecedence: Precedence {
        return precedences[curToken.type] ?? .lowest
    }
    
    private func expectNext(type: TokenType) -> Bool {
        if nextToken.type == type {
            advance()
            return true
        } else {
            let error = "expected next token to be \(type), got \(nextToken.literal)"
            errors.append(error)
            return false
        }
    }
    
    // MARK: parsing
    
    private func parseStatement() -> Statement {
        let expression = parseExpression()
        let statement = ExpressionStatement(token: curToken, expression: expression)
        
        return statement
    }
    
    private func parseIdentifier() -> Identifier {
        return Identifier(token: curToken, value: curToken.literal)
    }
    
    private func parseBoolean() -> Expression {
        return BooleanLiteral(token: curToken, value: curToken.type == .true)
    }
    
    private func parseVariable() -> Variable {
        return Variable(token: curToken, value: curToken.literal)
    }
    
    private func parseNumber() -> NumberLiteral {
        
        guard let value = Double(curToken.literal) else {
            errors.append("could not parse \(curToken.literal) as Number")
            return NumberLiteral(token: curToken, value: 0)
        }
        
        return NumberLiteral(token: curToken, value: CGFloat(value))
    }
    
    private func parseExpression(precedence: Precedence = .lowest) -> Expression {

        guard let prefix = prefixFunction[curToken.type] else {
            errors.append(("no prefix parse function for \(curToken.literal)"))
            return EmptyNode()
        }
        
        var leftExp = prefix()
        
        while precedence.rawValue < nextPrecedence.rawValue {
            
            guard let infix = infixFunction[nextToken.type] else {
                return leftExp
            }
            
            advance()
            leftExp = infix(leftExp)
        }
        
        return leftExp
    }
    
    private func parsePrefixExpression() -> Expression {
        
        let token = curToken
        let op = curToken.literal
        
        advance()
        
        let expression = PrefixExpression(token: token, op: op,
                                          right: parseExpression(precedence: .prefix))
        
        return expression
    }

    private func parseInfixExpression(left: Expression) -> Expression {
        
        let token = curToken
        let op = curToken.literal
        
        let precedence = currentPrecedence
        advance()
        let right = parseExpression(precedence: precedence)
        
        return InfixExpression(token: token, left: left, op: op, right: right)
    }
    
    private func parseGroupedExpression() -> Expression {
        
        advance()
        
        let expression = parseExpression()
        
        if !expectNext(type: .rParen) {
            return EmptyNode()
        }
        
        return expression
    }
    
    private func parseIfExpression() -> Expression {
        
        let token = curToken
        
        if !expectNext(type: .lParen) {
            return EmptyNode()
        }
        
        advance()
        
        let condition = parseExpression()
        
        if !expectNext(type: .rParen) {
            return EmptyNode()
        }
        
        if !expectNext(type: .lBracket) {
            return EmptyNode()
        }
        
        advance()
        
        let consequence = parseBlockStatement()
        
        var alternative: BlockStatement? = nil
        
        if nextToken.type == .else {
            advance()
            
            if !expectNext(type: .lBracket) {
                return EmptyNode()
            }
            
            advance()

            alternative = parseBlockStatement()
        }
        
        return IfExpression(token: token, condition: condition, consequence: consequence, alternative: alternative)
    }
    
    private func parseBlockStatement() -> BlockStatement {
        let token = curToken
        
        var statements: [Statement] = []
        
        while curToken.type != .rBracket && curToken.type != .eof {
            statements.append(parseStatement())
            advance()
        }
        
        return BlockStatement(token: token, statements: statements)
    }
    
    private func parseFunctionLiteral() -> Expression {
        
        let token = curToken
        
        advance()
        
        let name = parseIdentifier()
        
        advance()

        var parameters: [Variable] = []
        
        while curToken.type == .variable {
            parameters.append(parseVariable())
            advance()
        }
        
        var statements: [Statement] = []
        
        while curToken.type != .end && curToken.type != .eof {
            statements.append(parseStatement())
            advance()
        }
        
        let body = BlockStatement(token: token, statements: statements)
        
        return FunctionLiteral(token: token, name: name, parameters: parameters, body: body)
    }
    
    private func parseRepeatExpression() -> Expression {
    
        let token = curToken
        
        if !expectNext(type: .Number) {
            return EmptyNode()
        }
        
        let count = parseNumber()
        
        if !expectNext(type: .lBracket) {
            return EmptyNode()
        }
        
        advance()
        
        let statement = parseBlockStatement()
        
        return RepeatExpression(token: token, count: Int(count.value), statement: statement)
    }
    
    private func parseCallExpression(identifier: Expression) -> Expression {
        
        let token = curToken
        let name = identifier
        
        var arguments: [Expression] = []
        
        if nextToken.type == .rParen {
            advance()
            return CallExpression(token: token, name: name, arguments: arguments)
        }
        
        advance()
        arguments.append(parseExpression())
        
        while nextToken.type == .comma {
            advance()
            advance()
            arguments.append(parseExpression())
        }
        
        if !expectNext(type: .rParen) {
            return EmptyNode()
        }

        return CallExpression(token: token, name: name, arguments: arguments)
    }
}
