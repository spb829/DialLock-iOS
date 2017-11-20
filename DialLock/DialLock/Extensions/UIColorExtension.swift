//
//  UIColorExtension.swift
//  DialLock
//
//  Created by Mac Pro on 2017. 11. 20..
//  Copyright © 2017년 Eric.Park. All rights reserved.
//

import UIKit

extension UIColor {
    /**
     * Returns a color with adjusted saturation and brigtness than can be used to
     * indicate control is disabled.
     */
    func disabledColor() -> UIColor {
        var h = CGFloat(0)
        var s = CGFloat(0)
        var b = CGFloat(0)
        var a = CGFloat(0)
        
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s * 0.5, brightness: b * 1.2, alpha: a)
    }
}
