//
//  Command.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

struct CommandObject: Object {
    var value: Command

    var type: ObjectType {
        return .command
    }
}
