//
//  ViewController.swift
//  quote
//
//  Created by jihye choe on 3/23/16.
//  Copyright © 2016 jihye choe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    @IBAction func share(sender: UIButton) {
        print("digit = \(display.text!)")
    }
}

