//
//  Interpreter.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

public class Interpreter {
    
    public init() {}
    
    public func run(code: String) -> NSImage {
        let evaluator = Evaluator()
        return evaluator.eval(code: code)
    }
}
