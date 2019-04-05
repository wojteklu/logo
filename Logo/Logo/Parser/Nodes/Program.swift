import Foundation

struct Program: Node {
    let statements: [Statement]
    
    var description: String {
        return statements.map({"\($0)"}).joined(separator: " ")
    }
}
