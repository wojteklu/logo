//
//  RepeatExpression.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

struct RepeatExpression: Expression {
    let token: Token
    let count: Int
    let statement: BlockStatement
    
    var description: String {
        return "repeat \(count) [ \(statement) ]"
    }
}
