//
//  Foundation.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

enum Command {
    case left(heading: CGFloat)
    case right(heading: CGFloat)
    case forward(fromX: CGFloat, fromY: CGFloat, toX: CGFloat, toY: CGFloat)
    case back(fromX: CGFloat, fromY: CGFloat, toX: CGFloat, toY: CGFloat)
}

func left(args: [Object], environment: inout Environment) -> Object {
    
    guard args.count == 1 else {
        return Error(message: "wrong number of arguments in left function")
    }
    
    guard let argument = args[0] as? Number else {
        return Error(message: "wrong type of argument in left function")
    }
    
    // save new heading to environment
    let currentHeading = environment.get(constant: .heading)! as! Number
    let heading = Number(value: CGFloat((Int(currentHeading.value) + Int(argument.value)) % 360))
    environment.set(constant: .heading, value: heading)

    return CommandObject(value: .left(heading: heading.value))
}

func right(args: [Object], environment: inout Environment) -> Object {
    
    guard args.count == 1 else {
        return Error(message: "wrong number of arguments in right function")
    }
    
    guard let argument = args[0] as? Number else {
        return Error(message: "wrong type of argument in right function")
    }
    
    // save new heading to environment
    let currentHeading = environment.get(constant: .heading)! as! Number
    let heading = Number(value: CGFloat((Int(currentHeading.value) - Int(argument.value)) % 360))
    environment.set(constant: .heading, value: heading)
    
    return CommandObject(value: .right(heading: argument.value))
}

func forward(args: [Object], environment: inout Environment) -> Object {
    
    guard args.count == 1 else {
        return Error(message: "wrong number of arguments in forward function")
    }
    
    guard let argument = args[0] as? Number else {
        return Error(message: "wrong type of argument in forward function")
    }
    
    let currentHeading = environment.get(constant: .heading)! as! Number
    let fromX = environment.get(constant: .x)! as! Number
    let fromY = environment.get(constant: .y)! as! Number
    
    var newPosition = CGPoint(x: fromX.value, y: fromY.value)
    newPosition = newPosition.translate(by: argument.value, angle: currentHeading.value)

    // save new heading to environment
    environment.set(constant: .x, value: Number(value: newPosition.x))
    environment.set(constant: .y, value: Number(value: newPosition.y))
    
    return CommandObject(value: .forward(fromX: fromX.value,
                                       fromY: fromY.value,
                                       toX: newPosition.x,
                                       toY: newPosition.y))
}

func back(args: [Object], environment: inout Environment) -> Object {
    
    guard args.count == 1 else {
        return Error(message: "wrong number of arguments in back function")
    }
    
    guard let argument = args[0] as? Number else {
        return Error(message: "wrong type of argument in back function")
    }
    
    var currentHeading = environment.get(constant: .heading)! as! Number
    let fromX = environment.get(constant: .x)! as! Number
    let fromY = environment.get(constant: .y)! as! Number
    
    currentHeading = Number(value: currentHeading.value + 180)
    let heading = Number(value:  currentHeading.value + 180)
    
    var newPosition = CGPoint(x: fromX.value, y: fromY.value)
    newPosition = newPosition.translate(by: argument.value, angle: currentHeading.value)
    
    // save new heading and position to environment
    environment.set(constant: .x, value: Number(value: newPosition.x))
    environment.set(constant: .y, value: Number(value: newPosition.y))
    environment.set(constant: .heading, value: heading)
    
    return CommandObject(value: .forward(fromX: fromX.value,
                                         fromY: fromY.value,
                                         toX: newPosition.x,
                                         toY: newPosition.y))
}

func random(args: [Object], environment: inout Environment) -> Object {
    
    guard args.count == 1 else {
        return Error(message: "wrong number of arguments in random function")
    }
    
    guard let argument = args[0] as? Number else {
        return Error(message: "wrong type of argument in random function")
        
    }
    
    let random = Int(arc4random_uniform(UInt32(argument.value)))
    return Number(value: CGFloat(random))
}
