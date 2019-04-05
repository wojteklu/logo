import Foundation

struct Stack: Object {
    private var stack: [String] = []
    
    var type: ObjectType {
        return .stack
    }
    
    mutating func push(_ value: String) {
        stack.append(value)
    }
    
    mutating func pop() {
        stack.remove(at: stack.count-1)
    }
    
    func occurences(of value: String) -> Int {
        return stack.filter({ $0 == value }).count
    }
}
