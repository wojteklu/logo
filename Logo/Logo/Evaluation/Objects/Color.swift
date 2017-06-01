//
//  Color.swift
//  Logo
//
//  Created by Rafael Machado on 29/05/17.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

struct Color: Object {
    var value: NSColor
    
    var type: ObjectType {
        return .color
    }
}
