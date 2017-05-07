//
//  Geometry.swift
//  Logo
//
//  Created by Wojtek on 01/05/2017.
//  Copyright © 2017 wojteklu. All rights reserved.
//

import Foundation

extension CGSize {
    var center: CGPoint {
        return CGPoint(x: self.width/2, y: self.height/2)
    }
}

extension CGFloat {
    var radian: CGFloat {
        return CGFloat(self) * .pi / 180
    }
}

extension CGPoint {
    
    func translate(by distance: CGFloat, angle: CGFloat) -> CGPoint {
        let transform = CGAffineTransform(translationX: x, y: y)
            .rotated(by: angle.radian)
        return CGPoint(x: -distance, y: 0).applying(transform)
    }
}
