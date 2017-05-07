//
//  Number.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

struct Number: Object {
    var value: CGFloat
    
    var type: ObjectType {
        return .Number
    }
}
