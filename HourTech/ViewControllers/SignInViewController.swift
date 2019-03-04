//
//  SignInViewController.swift
//  HourTech
//
//  Created by Maggie on 2019-02-27.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var navigationBarSignIn: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardOnTap()
        navigationBarSignIn.setValue(true, forKey: "hidesShadow")

    }
    
    @IBAction func closeSignInTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func needToRegisterTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "signup_signin_segue", sender: self)
    }
    

}
