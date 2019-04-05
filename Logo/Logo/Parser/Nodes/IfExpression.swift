import Foundation

struct IfExpression: Expression {
    let token: Token
    let condition: Expression
    let consequence: BlockStatement
    let alternative: BlockStatement?
    
    init(token: Token, condition: Expression, consequence: BlockStatement, alternative: BlockStatement? = nil) {
        self.token = token
        self.condition = condition
        self.consequence = consequence
        self.alternative = alternative
    }
    
    var description: String {
        var result = "if (\(condition)) [ \(consequence) ]"
        
        if let alternative = alternative {
            result += " else [ \(alternative) ]"
        }

        return result
    }
}
