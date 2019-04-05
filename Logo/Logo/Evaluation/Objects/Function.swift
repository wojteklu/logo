import Foundation

struct Function: Object  {
    var name: Identifier
    var parameters: [Variable]
    var body: BlockStatement
    
    init(name: Identifier, parameters: [Variable], body: BlockStatement) {
        self.name = name
        self.parameters = parameters
        self.body = body
    }
    
    var type: ObjectType {
        return .function
    }
}
