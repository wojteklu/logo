//
//  PrefixExpression.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

struct PrefixExpression: Expression {
    let token: Token
    let op: String
    let right: Expression

    var description: String {
        return "(\(op)\(right))"
    }
}
