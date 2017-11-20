//
//  CATransactionExtension.swift
//  DialLock
//
//  Created by Mac Pro on 2017. 11. 20..
//  Copyright © 2017년 Eric.Park. All rights reserved.
//

import UIKit

extension CATransaction {
    static func doWithNoAnimation(action:()->Void) {
        CATransaction.begin()
        CATransaction.setValue(true, forKey: kCATransactionDisableActions)
        action()
        CATransaction.commit()
    }
}
