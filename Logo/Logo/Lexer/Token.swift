//
//  Token.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

struct Token: Equatable {
    let type: TokenType
    let literal: String
    
    init(type: TokenType, literal: String = "") {
        self.type = type
        self.literal = literal
    }
    
    static func ==(lhs: Token, rhs: Token) -> Bool {
        return lhs.type == rhs.type && lhs.literal == rhs.literal
    }
}

enum TokenType: String {
    case identifier
    case to
    case end
    case variable
    case Number
    case string
    case `if`
    case `else`
    case `repeat`
    case `true`
    case `false`
    case lBracket = "["
    case rBracket = "]"
    case lParen = "("
    case rParen = ")"
    case plus = "+"
    case minus = "-"
    case asterisk = "*"
    case slash = "/"
    case equal = "="
    case not_equal = "!="
    case lt = "<"
    case gt = ">"
    case illegal
    case comma
    case eof
}
