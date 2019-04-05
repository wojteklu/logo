import Foundation

struct Error: Object {
    let message: String
    
    var type: ObjectType {
        return .error
    }
}
