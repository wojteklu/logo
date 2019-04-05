import Foundation

struct Identifier: Expression {
    let token: Token
    let value: String
    
    var description: String {
        return value
    }
}
