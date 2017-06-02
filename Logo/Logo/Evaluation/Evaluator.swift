//
//  Evaluator.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

final class Evaluator {
    private let builtins: [String: Builtin]
    private var commands: [CommandObject] = []
    private let canvasSize: CGSize = NSSize(width: 800, height: 800)
    private let startHeading: CGFloat = -90

    init() {
        builtins = [
            "fd": Builtin(identifier: .forward),
            "bk": Builtin(identifier: .back),
            "lt": Builtin(identifier: .left),
            "rt": Builtin(identifier: .right),
            "forward": Builtin(identifier: .forward),
            "back": Builtin(identifier: .back),
            "left": Builtin(identifier: .left),
            "right": Builtin(identifier: .right),
            "random": Builtin(identifier: .random),
            "setColor": Builtin(identifier: .setColor),
            "penUp": Builtin(identifier: .penUp),
            "penDown": Builtin(identifier: .penDown),
        ]
    }
    
    func eval(code: String) -> NSImage {
        let lexer = Lexer(code: code)
        let parser = Parser(lexer: lexer)
        let program = parser.parse()
        let parsingErrors = parser.errors
        
        if parsingErrors.count > 0 {
            let context = Canvas(size: canvasSize)
            return context.draw(text: "Parsing error: \(parsingErrors[0])")
        }
        
        var environment = Environment()
        
        environment.set(constant: .heading, value: Number(value: startHeading))
        environment.set(constant: .x, value: Number(value: canvasSize.center.x))
        environment.set(constant: .y, value: Number(value: canvasSize.center.y))
        environment.set(constant: .stack, value: Stack())
        environment.set(name: "black", value: Color(value: .black))
        environment.set(name: "darkGray", value: Color(value: .darkGray))
        environment.set(name: "lightGray", value: Color(value: .lightGray))
        environment.set(name: "white", value: Color(value: .white))
        environment.set(name: "gray", value: Color(value: .gray))
        environment.set(name: "red", value: Color(value: .red))
        environment.set(name: "green", value: Color(value: .green))
        environment.set(name: "blue", value: Color(value: .blue))
        environment.set(name: "cyan", value: Color(value: .cyan))
        environment.set(name: "yellow", value: Color(value: .yellow))
        environment.set(name: "magenta", value: Color(value: .magenta))
        environment.set(name: "orange", value: Color(value: .orange))
        environment.set(name: "purple", value: Color(value: .purple))
        environment.set(name: "brown", value: Color(value: .brown))
        
        let output = eval(node: program, environment: &environment)
        
        switch (output) {
        case let error as Error:
            let context = Canvas(size: canvasSize)
            return context.draw(text: error.message)
        default:
            let context = Canvas(size: canvasSize)
            return context.draw(commands: commands.map {$0.value})
        }
    }
    
    func eval(node: Node, environment: inout Environment) -> Object {
        switch (node) {
        case let node as Program:
            return eval(statements: node.statements, environment: &environment)
        case let node as BlockStatement:
            return eval(statements: node.statements, environment: &environment)
        case let node as ExpressionStatement:
            return eval(node: node.expression, environment: &environment)
        case let node as NumberLiteral:
            return Number(value: node.value)
        case let node as Identifier:
            return eval(identifier: node, environment: environment)
        case let node as Variable:
            return eval(variable: node, environment: environment)
        case let node as BooleanLiteral:
            return Boolean(value: node.value)
        case let node as PrefixExpression:
            let right = eval(node: node.right, environment: &environment)
            return evalPrefixExpression(op: node.op, right: right)
        case let node as InfixExpression:
            let left = eval(node: node.left, environment: &environment)
            let right = eval(node: node.right, environment: &environment)
            return evalInfixExpression(op: node.op, left: left, right: right)
        case let node as IfExpression:
            return eval(ifExpression: node, environment: &environment)
        case let function as FunctionLiteral:
            let function = Function(name: function.name, parameters: function.parameters, body: function.body)
            environment.set(name: function.name.value, value: function)
            return function
        case let node as CallExpression:
            return eval(callExpression: node, environment: &environment)
        case let node as RepeatExpression:
            return eval(repeatExpression: node, environment: &environment)
        default:
            return Null()
        }
    }
    
    func eval(statements: [Statement], environment: inout Environment) -> Object {
        var result: Object = Null()
        
        for statement in statements {
            result = eval(node: statement, environment: &environment)
            
            if result is Error {
                return result
            }
        }
        
        return result
    }
    
    func eval(identifier: Identifier, environment: Environment) -> Object {
        
        if let value = environment.get(name: identifier.value) {
            return value
        }

        if let value = builtins[identifier.value] {
            return value
        }
        
        return Error(message: "identifier not found \(identifier.value)")
    }
    
    func eval(variable: Variable, environment: Environment) -> Object {
        
        guard let value = environment.get(name: variable.value) else {
            return Error(message: "variable not found \(variable.value)")
        }
        
        return value
    }
    
    func eval(expressions: [Expression], environment: inout Environment) -> [Object] {
        var results: [Object] = []
        
        for expression in expressions {
            let evaluated = eval(node: expression, environment: &environment)
            
            if evaluated is Error {
                return [evaluated]
            }
            
            results.append(evaluated)
        }
        
        return results
    }
    
    func evalPrefixExpression(op: String, right: Object) -> Object {
        switch op {
        case "-":
            return evalMinusPrefixOperatorExpression(right: right)
        default:
            return Error(message: "unknown operator: \(op)\(right.type)")
        }
    }
    
    func evalMinusPrefixOperatorExpression(right: Object) -> Object {
        
        guard let right = right as? Number else {
            return Null()
        }
        
        return Number(value: -right.value)
    }
    
    func evalInfixExpression(op: String, left: Object, right: Object) -> Object {
        switch (left, right) {
        case let pair as (Number, Number):
            return evalNumberInfixExpression(op: op, left: pair.0, right: pair.1)
        case let pair as (Boolean, Boolean):
            return evalBooleanInfixExpression(op: op, left: pair.0, right: pair.1)
        default:
            return Error(message: "unknown operator: \(left.type)\(op)\(right.type)")
        }
    }
    
    func evalBooleanInfixExpression(op: String, left: Boolean, right: Boolean) -> Object {
        switch op {
        case "=":
            return Boolean(value: left.value == right.value)
        case "!=":
            return Boolean(value: left.value != right.value)
        default:
            return Error(message: "unknown operator: \(left.type)\(op)\(right.type)")
        }
    }
    
    func evalNumberInfixExpression(op: String, left: Number, right: Number) -> Object {
        switch op {
        case "+":
            return Number(value: left.value + right.value)
        case "-":
            return Number(value: left.value - right.value)
        case "*":
            return Number(value: left.value * right.value)
        case "/":
            return Number(value: left.value/right.value)
        case "<":
            return Boolean(value: left.value < right.value)
        case ">":
            return Boolean(value: left.value > right.value)
        case "=":
            return Boolean(value: left.value == right.value)
        case "!=":
            return Boolean(value: left.value != right.value)
        default:
            return Error(message: "unknown operator: \(left.type)\(op)\(right.type)")
        }
    }
    
    func eval(ifExpression: IfExpression, environment: inout Environment) -> Object {
        let condition = eval(node: ifExpression.condition, environment: &environment)
        
        let isTrue = (condition as? Boolean)?.value ?? false
        
        if isTrue {
            return eval(node: ifExpression.consequence, environment: &environment)
        } else if let alternative = ifExpression.alternative {
            return eval(node: alternative, environment: &environment)
        } else {
            return Null()
        }
    }
    
    func eval(repeatExpression: RepeatExpression, environment: inout Environment) -> Object {
        var statements: [Statement] = []
        
        for _ in 0..<repeatExpression.count {
            statements.append(repeatExpression.statement)
        }
        
        return eval(statements: statements, environment: &environment)
    }
    
    func eval(callExpression: CallExpression, environment: inout Environment) -> Object {
        let expression = eval(node: callExpression.name, environment: &environment)
        
        if expression is Error {
            return expression
        }
        
        let args = eval(expressions: callExpression.arguments, environment: &environment)
        
        if args.count == 1 && args[0] is Error {
            return args[0]
        }
        
        let result = execute(expression: expression, args: args, environment: &environment)
        
        if let command = result as? CommandObject {
            commands.append(command)
        }
        
        return result
    }

    func execute(expression: Object, args: [Object], environment: inout Environment) -> Object {
        
        switch (expression) {
        case let function as Function:
            return execute(function: function, args: args, environment: &environment)
        case let builtin as Builtin:
            return builtin.function(args, &environment)
        default:
            return Error(message: "not a function \(expression.type)")
        }
    }
    
    func execute(function: Function, args: [Object], environment: inout Environment) -> Object {
        
        // update function stack
        var stack = environment.get(constant: .stack) as! Stack
        stack.push(function.name.value)
        environment.set(constant: .stack, value: stack)
        
        var evalEnvironment = environment
        
        // if function is already on stack, copy environment
        if stack.occurences(of: function.name.value) > 1 {
            evalEnvironment = environment.copy()
        }
        
        // pass function arguments to environment
        for (index, param) in function.parameters.enumerated() {
            evalEnvironment.set(name: param.value, value: args[index])
        }
        
        let result = eval(node: function.body, environment: &evalEnvironment)
        
        // pop function froms stack and save
        stack.pop()
        environment.set(constant: .stack, value: stack)
        
        return result
    }
}
