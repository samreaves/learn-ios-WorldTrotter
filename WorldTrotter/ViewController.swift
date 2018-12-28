//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Sam Reaves on 12/28/18.
//  Copyright © 2018 Sam Reaves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstFrame = CGRect(x: 160, y: 240,
                                width: 100, height: 150)
        let firstView = UIView(frame: firstFrame)
        firstView.backgroundColor = UIColor.blue
        view.addSubview(firstView)
    }
}

