import Cocoa

class WindowController: NSWindowController {

    @IBAction private func play(_ sender: Any) {
        (window?.contentViewController as? ViewController)?.evaluate()
    }
}
