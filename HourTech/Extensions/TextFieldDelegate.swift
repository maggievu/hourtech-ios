//
//  TextFieldDelegate.swift
//  HourTech
//
//  Created by Maggie on 2019-02-27.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
//        if let text = textField.text, let url = URL(string: text) {
//            let request = URLRequest(url: url)
//            webkitView.load(request)
//            webkitView.allowsBackForwardNavigationGestures = true
//        }
        
        return true
    }
}
