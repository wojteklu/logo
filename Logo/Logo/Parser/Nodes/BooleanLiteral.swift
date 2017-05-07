//
//  BooleanLiteral.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

struct BooleanLiteral: Expression {
    let token: Token
    let value: Bool
    
    var description: String {
        return "\(value)"
    }
}
