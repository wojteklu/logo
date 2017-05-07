//
//  Lexer.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 Logo. All rights reserved.
//

final class Lexer {
    private let code: String
    private var currentPosition: Int
    private var currentChar: UnicodeScalar
    
    private let keywords: [String: TokenType] = ["to": .to,
                                                 "end": .end,
                                                 "if": .if,
                                                 "else": .else,
                                                 "true": .true,
                                                 "false": .false,
                                                 "repeat": .repeat]
    
    init(code: String) {
        self.code = code
        self.currentPosition = 0
        self.currentChar = code[currentPosition]
    }
    
    func lex() -> [Token] {
        var tokens: [Token] = []
        var token: Token
        
        repeat {
            token = nextToken()
            tokens.append(token)
        } while token.type != .eof
        
        return tokens
    }
    
    func nextToken() -> Token {
        let token: Token
        
        skipWhitespace()
        
        switch currentChar {
        case "[":
            token = Token(type: .lBracket, literal: String(currentChar))
        case "]":
            token = Token(type: .rBracket, literal: String(currentChar))
        case "(":
            token = Token(type: .lParen, literal: String(currentChar))
        case ")":
            token = Token(type: .rParen, literal: String(currentChar))
        case "+":
            token = Token(type: .plus, literal: String(currentChar))
        case "-":
            token = Token(type: .minus, literal: String(currentChar))
        case "*":
            token = Token(type: .asterisk, literal: String(currentChar))
        case "<":
            token = Token(type: .lt, literal: String(currentChar))
        case ">":
            token = Token(type: .gt, literal: String(currentChar))
        case "/":
            token = Token(type: .slash, literal: String(currentChar))
        case "=":
            token = Token(type: .equal, literal: String(currentChar))
        case ",":
            token = Token(type: .comma, literal: String(currentChar))
        case "!":
            if nextChar() == "=" {
                let previousChar = currentChar
                readChar()
                token = Token(type: .not_equal, literal: String(previousChar) + String(currentChar))
            } else {
                token = Token(type: .illegal, literal: String(currentChar))
            }
        case ":":
            readChar()
            return Token(type: .variable, literal: readString())
        case UnicodeScalar(10), UnicodeScalar(0):
            token = Token(type: .eof)
        default:
            if currentChar.isLetter {
                let literal = readString()
                let type = keywords[literal] ?? .identifier
                return Token(type: type, literal: literal)
            } else if currentChar.isDigit {
                return Token(type: .Number, literal: readNumber())
            } else {
                token = Token(type: .illegal, literal: String(currentChar))
                print("wojtek")
                print(currentChar.value)
            }
        }
        
        readChar()
        
        return token
    }

    private func readChar() {
        let nextPosition = currentPosition + 1
        currentChar = (nextPosition >= code.characters.count) ? UnicodeScalar(0) : code[nextPosition]
        currentPosition = nextPosition
    }
    
    private func readString() -> String {
        let startPosition = currentPosition
        
        while currentChar.isLetter {
            readChar()
        }
        
        return code[startPosition..<currentPosition]
    }
    
    private func readNumber() -> String {
        let startPosition = currentPosition
        
        while currentChar.isDigit {
            readChar()
        }
        
        return code[startPosition..<currentPosition]
    }

    private func skipWhitespace() {
        while currentChar.isWhiteSpace {
            readChar()
        }
    }
    
    private func nextChar() -> UnicodeScalar {
        let nextPosition = currentPosition + 1
        if nextPosition >= code.characters.count {
            return UnicodeScalar(0)
        } else {
            return code[nextPosition]
        }
    }
}
