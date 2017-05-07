//
//  ExpressionStatement.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

struct ExpressionStatement: Statement {
    let token: Token
    let expression: Expression

    var description: String {
        return "\(expression)"
    }
}
