//
//  Environment.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

enum Constant: String {
    case heading
    case stack
    case x
    case y
}

class Environment {
    var map: [String: Object] = [:]
    
    func get(name: String) -> Object? {
        return map[name]
    }
    
    func get(constant: Constant) -> Object? {
        return get(name: constant.rawValue)
    }
    
    func set(name: String, value: Object) {
        map[name] = value
    }
    
    func set(constant: Constant, value: Object) {
        map[constant.rawValue] = value
    }
    
    func copy() -> Environment {
        let environment = Environment()
        environment.map = map
        return environment
    }
}
