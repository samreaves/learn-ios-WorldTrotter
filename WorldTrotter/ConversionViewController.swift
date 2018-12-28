//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Sam Reaves on 12/28/18.
//  Copyright © 2018 Sam Reaves. All rights reserved.
//

import UIKit

class ConversionViewController : UIViewController {
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            celsiusLabel.text = textField.text
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func dismissTextField(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
}
