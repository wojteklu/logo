//
//  CallExpression.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

struct CallExpression: Expression {
    let token: Token
    let name: Expression
    let arguments: [Expression]
    
    var description: String {
        let argumentsString = arguments.map({"\($0)"}).joined(separator: ", ")
        return "\(name)(\(argumentsString))"
    }
}
