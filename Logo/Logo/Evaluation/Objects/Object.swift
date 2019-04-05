import Foundation

enum ObjectType {
    case Number
    case boolean
    case null
    case error
    case function
    case builtin
    case command
    case stack
    case color
}

protocol Object {
    var type: ObjectType { get }
}


