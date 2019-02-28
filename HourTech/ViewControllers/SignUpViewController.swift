//
//  SignUpViewController.swift
//  HourTech
//
//  Created by Maggie on 2019-02-26.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardOnTap()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeSignUpTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    */

}
