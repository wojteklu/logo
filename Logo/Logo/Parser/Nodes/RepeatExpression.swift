import Foundation

struct RepeatExpression: Expression {
    let token: Token
    let count: Int
    let statement: BlockStatement
    
    var description: String {
        return "repeat \(count) [ \(statement) ]"
    }
}
