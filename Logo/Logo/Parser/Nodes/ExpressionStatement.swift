import Foundation

struct ExpressionStatement: Statement {
    let token: Token
    let expression: Expression

    var description: String {
        return "\(expression)"
    }
}
