//
//  Builtin.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

enum BuiltinType {
    case left
    case right
    case forward
    case back
    case random
}

struct Builtin: Object {
    var identifier: BuiltinType
    var function: (_ args: [Object], _ environment: inout Environment) -> Object {
        switch(identifier) {
        case .left:
            return left
        case .right:
            return right
        case .forward:
            return forward
        case .back:
            return back
        case .random:
            return random
        }
    }
    
    var type: ObjectType {
        return .builtin
    }
}
