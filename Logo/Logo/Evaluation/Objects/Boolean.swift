//
//  Boolean.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

struct Boolean: Object {
    var value: Bool
    
    var type: ObjectType {
        return .boolean
    }
}
