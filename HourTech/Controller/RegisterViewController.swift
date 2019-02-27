//
//  RegisterViewController.swift
//  HourTech
//
//  Created by Noppawit Hansompob on 27/2/2562 BE.
//  Copyright © 2562 Maggie VU. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func registerButtontapped(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                print("Registration Success!!")
                
                self.performSegue(withIdentifier: "toSearchOutput", sender: self)
            }
            
        }
    }
}
