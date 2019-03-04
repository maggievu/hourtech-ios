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
    @IBOutlet weak var navigationBarSignUp: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardOnTap()
        navigationBarSignUp.setValue(true, forKey: "hidesShadow")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeSignUpTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
