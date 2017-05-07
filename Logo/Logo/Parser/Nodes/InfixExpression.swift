//
//  InfixExpression.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

struct InfixExpression: Expression {
    let token: Token
    let left: Expression
    let op: String
    let right: Expression
    
    var description: String {
        return "(\(left) \(op) \(right))"
    }
    
}
