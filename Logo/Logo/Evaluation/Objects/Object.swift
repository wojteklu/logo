//
//  Object.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

enum ObjectType {
    case Number
    case boolean
    case null
    case error
    case function
    case builtin
    case command
    case stack
    case color
}

protocol Object {
    var type: ObjectType { get }
}


