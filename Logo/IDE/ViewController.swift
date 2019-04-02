import Cocoa
import Logo

class ViewController: NSViewController {
    @IBOutlet private var codeTextView: LogoSyntaxTextView!
    @IBOutlet private var outputImageView: NSImageView!
    private let interpreter = Interpreter()

    func evaluate() {
        let code = codeTextView.string
        guard code.count > 0 else { return }

        DispatchQueue.main.async {
            self.outputImageView.image = self.interpreter.run(code: code,
                                                              canvasSize: self.outputImageView.bounds.size)
        }
    }
}
