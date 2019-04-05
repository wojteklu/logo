import Foundation

struct FunctionLiteral: Expression {
    let token: Token
    let name: Identifier
    let parameters: [Variable]
    let body: BlockStatement

    var description: String {
        return "to \(name) \(parameters.map({"\($0)"}).joined(separator: " ")) [ \(body) ]"
    }
}
