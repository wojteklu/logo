import Foundation

struct InfixExpression: Expression {
    let token: Token
    let left: Expression
    let op: String
    let right: Expression
    
    var description: String {
        return "(\(left) \(op) \(right))"
    }
    
}
