//
//  Error.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

struct Error: Object {
    let message: String
    
    var type: ObjectType {
        return .error
    }
}
