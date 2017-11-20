//
//  CGVectorExtension.swift
//  DialLock
//
//  Created by Mac Pro on 2017. 11. 20..
//  Copyright © 2017년 Eric.Park. All rights reserved.
//

import UIKit

extension CGVector {
    /**
     * Returns angle between vector and receiver in radians. Return is between
     * 0 and 2 * PI in clockwise direction.
     */
    func angleFromVector(vector: CGVector) -> Double {
        let angle = Double(atan2(dy, dx) - atan2(vector.dy, vector.dx))
        return angle > 0 ? angle : angle + 2 * .pi
    }
}
