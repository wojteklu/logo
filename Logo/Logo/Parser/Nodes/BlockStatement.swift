import Foundation

struct BlockStatement: Statement {
    let token: Token
    let statements: [Statement]

    var description: String {
        return statements.map({"\($0)"}).joined(separator: " ")
    }
}
