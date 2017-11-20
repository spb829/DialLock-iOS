//
//  ViewController.swift
//  DialLock
//
//  Created by Mac Pro on 2017. 11. 20..
//  Copyright © 2017년 Eric.Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var dialLock: DialLock!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dialLockRotated(sender: DialLock) {
        print("value: \(dialLock.value)")
    }
}

