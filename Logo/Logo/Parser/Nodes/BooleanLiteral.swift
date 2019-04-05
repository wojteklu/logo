import Foundation

struct BooleanLiteral: Expression {
    let token: Token
    let value: Bool
    
    var description: String {
        return "\(value)"
    }
}
