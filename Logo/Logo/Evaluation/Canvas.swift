//
//  Canvas.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

class Canvas {
    private let bitmapContext: CGContext
    private var heading: CGFloat = 0
    let size: CGSize

    init(size: CGSize) {
        self.size = size
        bitmapContext = CGContext(data: nil,
                                  width: Int(size.width),
                                  height: Int(size.height),
                                  bitsPerComponent: 8,
                                  bytesPerRow: Int(size.width) * 4,
                                  space: CGColorSpaceCreateDeviceRGB(),
                                  bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)!
    }
    
    func draw(commands: [Command]) -> NSImage {
        bitmapContext.flush()
        
        for c in commands {
            switch c {
            case .left(let heading):
                self.heading = heading
            case .right(let heading):
                self.heading = heading
            case .forward(let fromX, let fromY, let toX, let toY):
                drawLine(from: CGPoint(x: fromX, y: fromY), to: CGPoint(x: toX, y: toY))
            case .back(let fromX, let fromY, let toX, let toY):
                drawLine(from: CGPoint(x: fromX, y: fromY), to: CGPoint(x: toX, y: toY))
            case .change(let color):
                bitmapContext.setStrokeColor(color.cgColor)
                break
            }
        }
        
        return NSImage(cgImage: bitmapContext.makeImage()!, size: size)
    }
    
    func draw(text: String) -> NSImage {
        bitmapContext.flush()
        
        let image = NSImage(size: size, flipped: false) { rect -> Bool in
            
            let text = NSString(string: text)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.center
            
            let attributes = [
                NSFontAttributeName: NSFont.systemFont(ofSize: 50),
                NSParagraphStyleAttributeName: paragraphStyle
            ]
            
            text.draw(in: rect, withAttributes: attributes)
            
            return true
        }
        
        return image
    }
    
    private func drawLine(from start: CGPoint, to end: CGPoint) {
        bitmapContext.move(to: start)
        bitmapContext.addLine(to: end)
        bitmapContext.strokePath()
    }
    
}
