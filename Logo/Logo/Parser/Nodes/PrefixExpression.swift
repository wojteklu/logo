import Foundation

struct PrefixExpression: Expression {
    let token: Token
    let op: String
    let right: Expression

    var description: String {
        return "(\(op)\(right))"
    }
}
