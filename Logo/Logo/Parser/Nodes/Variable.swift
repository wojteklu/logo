//
//  Variable.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

struct Variable: Expression {
    let token: Token
    let value: String
    
    var description: String {
        return ":\(value)"
    }
}
