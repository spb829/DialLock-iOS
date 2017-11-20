//
//  CGRectExtension.swift
//  DialLock
//
//  Created by Mac Pro on 2017. 11. 20..
//  Copyright © 2017년 Eric.Park. All rights reserved.
//

import UIKit

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: origin.x + size.width / 2, y: origin.y + size.height / 2)
    }
}
