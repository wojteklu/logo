import Foundation

struct Number: Object {
    var value: CGFloat
    
    var type: ObjectType {
        return .Number
    }
}
