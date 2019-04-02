import Cocoa

class LogoSyntaxTextView: NSTextView {

    override func awakeFromNib() {
        font = NSFont(name: "Menlo", size: 15)
    }

    override func didChangeText() {
        guard let textStorage = textStorage else { return }

        textStorage.beginEditing()
        setTextColor(.white, range:NSRange(location: 0, length: string.count))

        colorText(regexString: "\\d",
                  color: NSColor(hexString: "d19a66"))

        colorText(regexString: "([a-zA-Z_{1}][a-zA-Z0-9_]+)(?=\\()",
                  color: NSColor(hexString: "61aeee"))

        colorText(regexString: "\\b(if|else|end|to|repeat)\\b",
                  color: NSColor(hexString: "c678dd"))

        colorText(regexString: "[:]\\w+",
                  color: NSColor(hexString: "e6c07b"))

        textStorage.endEditing()
    }

    private func colorText(regexString: String, color: NSColor) {
        guard let regex = try? NSRegularExpression(pattern: regexString, options: []) else {
            return
        }

        let matches = regex.matches(in: string,
                                    options: [],
                                    range: NSRange(location: 0, length: string.count))

        for match in matches {
            setTextColor(color, range: match.range)
        }
    }
}
