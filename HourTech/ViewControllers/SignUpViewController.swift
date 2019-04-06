//
//  SignUpViewController.swift
//  HourTech
//
//  Created by Maggie on 2019-02-26.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var navigationBarSignUp: UINavigationBar!
    
    var signUpUserId: String = ""
    let databaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardOnTap()
        navigationBarSignUp.setValue(true, forKey: "hidesShadow")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "search_segue", sender: self)
        }
    }
    
    @IBAction func closeSignUpTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        
        if firstNameTextField.text!.isEmpty {
            let alertController = UIAlertController(title: "Required field", message: "Please enter first name", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            if lastNameTextField.text!.isEmpty {
                let alertController = UIAlertController(title: "Required field", message: "Please enter last name", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                if emailTextField.text!.isEmpty {
                    let alertController = UIAlertController(title: "Required field", message: "Please enter email address", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    if passwordTextField.text != rePasswordTextField.text {
                        let alertController = UIAlertController(title: "Password must match", message: "Please re-type password", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                    } else {
                        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                            if error != nil {
                                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alertController.addAction(defaultAction)
                                
                                self.present(alertController, animated: true, completion: nil)
                            } else {
                                if Auth.auth().currentUser != nil {
                                    self.signUpUserId = Auth.auth().currentUser!.uid
                                }
                                print("signUpUserId: \(self.signUpUserId)")
                                
                                let usersRef = self.databaseRef.child("users")
                                let userItem = [
                                    self.signUpUserId : [
                                        "email": self.emailTextField.text!,
                                        "firstname": self.firstNameTextField.text!,
                                            "imgURL": " ",
                                            "lastname": self.lastNameTextField.text!,
                                            "title": "Client" ] as [String : Any]
                                    ]
                                usersRef.updateChildValues(userItem)
                                print("Perform Segue to search_segue")
                                self.performSegue(withIdentifier: "search_segue", sender: self)
                            }
                        }
                    }
                }
            }
        }
        
    }
    
}
