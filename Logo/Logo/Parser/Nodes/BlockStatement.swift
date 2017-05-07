//
//  BlockStatement.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

struct BlockStatement: Statement {
    let token: Token
    let statements: [Statement]

    var description: String {
        return statements.map({"\($0)"}).joined(separator: " ")
    }
}
