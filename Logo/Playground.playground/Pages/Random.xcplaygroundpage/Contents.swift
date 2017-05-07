import Logo

let fileURL = Bundle.main.url(forResource: "random", withExtension: "txt")
let code = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)

let interpreter = Interpreter()
interpreter.run(code: code)
