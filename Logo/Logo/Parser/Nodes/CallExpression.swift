import Foundation

struct CallExpression: Expression {
    let token: Token
    let name: Expression
    let arguments: [Expression]
    
    var description: String {
        let argumentsString = arguments.map({"\($0)"}).joined(separator: ", ")
        return "\(name)(\(argumentsString))"
    }
}
