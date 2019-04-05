import Foundation

extension String {
    
    subscript(index: Int) -> UnicodeScalar {
        return unicodeScalars[unicodeScalars.index(unicodeScalars.startIndex, offsetBy: index)]
    }
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
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
