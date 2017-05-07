//
//  Stack.swift
//  Logo
//
//  Created by Wojtek on 06/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

struct Stack: Object {
    private var stack: [String] = []
    
    var type: ObjectType {
        return .stack
    }
    
    mutating func push(_ value: String) {
        stack.append(value)
    }
    
    mutating func pop() {
        stack.remove(at: stack.count-1)
    }
    
    func occurences(of value: String) -> Int {
        return stack.filter({ $0 == value }).count
    }
}
