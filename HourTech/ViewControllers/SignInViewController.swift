//
//  SignInViewController.swift
//  HourTech
//
//  Created by Maggie on 2019-02-27.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignInViewController: UIViewController {
   
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var navigationBarSignIn: UINavigationBar!
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    let databaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
        self.dismissKeyboardOnTap()
        navigationBarSignIn.setValue(true, forKey: "hidesShadow")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "search_segue", sender: self)
        }
    }
    
    @IBAction func closeSignInTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func needToRegisterTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "signup_signin_segue", sender: self)
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "search_segue", sender: self)
            }
        }
    }
    
    @IBAction func googleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
}

extension SignInViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error)
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                return
            } else {
                print("Google signin Sucess!")
                
                if let user = Auth.auth().currentUser {
                    let uid = user.uid
                    print("Google-ID: \(uid)")
                    let email = user.email!
                    print("Google-email: \(String(describing: email))")
                    let photoURL = user.photoURL!
                    print("Google-photoURL: \(String(describing: photoURL))")
                    let givenName = user.displayName!
                    print("Google-givenName: \(String(describing: givenName))")
                    
                    let usersRef = self.databaseRef.child("users")
                    let userItem = [
                        uid : [
                            "email": email,
                            "firstname": givenName,
                            "imgURL": photoURL.absoluteString,
                            "lastname": " ",
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
