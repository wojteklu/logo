import Foundation

struct NumberLiteral: Expression {
    let token: Token
    let value: CGFloat

    var description: String {
        return "\(value)"
    }
}
