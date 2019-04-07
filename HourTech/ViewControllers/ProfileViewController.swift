//
//  ProfileViewController.swift
//  HourTech
//
//  Created by Maggie on 2019-04-02.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ProfileViewController: UIViewController {

    @IBOutlet weak var firstNameClient: UILabel!
    @IBOutlet weak var lastNameClient: UILabel!
    
    @IBOutlet weak var firstNameEdit: UITextField!
    @IBOutlet weak var lastNameEdit: UITextField!
    @IBOutlet weak var oldPasswordEdit: UITextField!
    @IBOutlet weak var newPasswordEdit: UITextField!
    @IBOutlet weak var confirmNewPasswordEdit: UITextField!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    var editFlag: Bool = true
    
    let databaseRef = Database.database().reference()
    
    var currentUserId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dismissKeyboardOnTap()
        
        if Auth.auth().currentUser != nil {
            currentUserId = Auth.auth().currentUser!.uid
            disableUITextfield(flag: editFlag)
            retrieveUserData()
        } else {
            let alertController = UIAlertController(title: "Required Signing In", message: "Please sign in to perform this action", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: { action in self.performSegue(withIdentifier: "signin_segue", sender: self) })
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        // edit profile function goes here, can add Save button on the bottom of the screen as well
        disableUITextfield(flag: !editFlag)
    }
    
    func retrieveUserData() {
        databaseRef.child("users").child(currentUserId).observe(.value, with: { (userSnapshot) in
            let dataDictionary = userSnapshot.value as! [String: Any]
            print("userSnapshot: \(userSnapshot)")
            
            self.firstNameClient.text = dataDictionary["firstname"] as? String
            self.lastNameClient.text = dataDictionary["lastname"] as? String
            self.firstNameEdit.text = dataDictionary["firstname"] as? String
            self.lastNameEdit.text = dataDictionary["lastname"] as? String
            self.userImageView.sd_setImage(with: URL(string: dataDictionary["imgURL"] as! String), placeholderImage: UIImage(named: "avatar"))
            
        })
    }
    
    func disableUITextfield(flag: Bool){
        if flag {
            firstNameEdit.isEnabled = false
            lastNameEdit.isEnabled = false
            oldPasswordEdit.isEnabled = false
            newPasswordEdit.isEnabled = false
            confirmNewPasswordEdit.isEnabled = false
        } else {
            firstNameEdit.isEnabled = true
            lastNameEdit.isEnabled = true
            oldPasswordEdit.isEnabled = true
            newPasswordEdit.isEnabled = true
            confirmNewPasswordEdit.isEnabled = true
        }
    }
    

}
