//
//  Utils.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

extension String {
    
    subscript(index: Int) -> UnicodeScalar {
        return unicodeScalars[unicodeScalars.index(unicodeScalars.startIndex, offsetBy: index)]
    }
    
    subscript (range: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return self[Range(start..<end)]
    }
}

extension UnicodeScalar {
    
    var isLetter: Bool {
        return CharacterSet.letters.contains(self)
    }
    
    var isWhiteSpace: Bool {
        return CharacterSet.whitespacesAndNewlines.contains(self)
    }
    
    var isDigit: Bool {
        return CharacterSet.decimalDigits.contains(self)
    }
}
