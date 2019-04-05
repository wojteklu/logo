import Foundation

struct Variable: Expression {
    let token: Token
    let value: String
    
    var description: String {
        return ":\(value)"
    }
}
