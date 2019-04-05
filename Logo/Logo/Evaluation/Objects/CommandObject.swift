import Foundation

struct CommandObject: Object {
    var value: Command

    var type: ObjectType {
        return .command
    }
}
