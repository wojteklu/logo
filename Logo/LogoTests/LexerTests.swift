import XCTest
@testable import Logo

class LexerTests: XCTestCase {
    
    func testLexer() {
        
        let code = "; identifierA identifierB repeat to end if else :variable 1 [ ] ( ) + - * / = < > true false != ! :index) ,"
        
        let expected: [Token] = [
            Token(type: .illegal, literal: ";"),
            Token(type: .identifier, literal: "identifierA"),
            Token(type: .identifier, literal: "identifierB"),
            Token(type: .repeat, literal: "repeat"),
            Token(type: .to, literal: "to"),
            Token(type: .end, literal: "end"),
            Token(type: .if, literal: "if"),
            Token(type: .else, literal: "else"),
            Token(type: .variable, literal: "variable"),
            Token(type: .Number, literal: "1"),
            Token(type: .lBracket, literal: "["),
            Token(type: .rBracket, literal: "]"),
            Token(type: .lParen, literal: "("),
            Token(type: .rParen, literal: ")"),
            Token(type: .plus, literal: "+"),
            Token(type: .minus, literal: "-"),
            Token(type: .asterisk, literal: "*"),
            Token(type: .slash, literal: "/"),
            Token(type: .equal, literal: "="),
            Token(type: .lt, literal: "<"),
            Token(type: .gt, literal: ">"),
            Token(type: .true, literal: "true"),
            Token(type: .false, literal: "false"),
            Token(type: .not_equal, literal: "!="),
            Token(type: .illegal, literal: "!"),
            Token(type: .variable, literal: "index"),
            Token(type: .rParen, literal: ")"),
            Token(type: .comma, literal: ","),
            Token(type: .eof)]
        
    
        let lexer = Lexer(code: code)
        let tokens = lexer.lex()
        
        for index in 0..<tokens.count {
            XCTAssertEqual(tokens[index], expected[index])
        }
    }
}
