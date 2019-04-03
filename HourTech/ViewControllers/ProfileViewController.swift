//
//  ProfileViewController.swift
//  HourTech
//
//  Created by Maggie on 2019-04-02.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var firstNameClient: UILabel!
    @IBOutlet weak var lastNameClient: UILabel!
    
    @IBOutlet weak var firstNameEdit: UITextField!
    @IBOutlet weak var lastNameEdit: UITextField!
    @IBOutlet weak var oldPasswordEdit: UITextField!
    @IBOutlet weak var newPasswordEdit: UITextField!
    @IBOutlet weak var confirmNewPasswordEdit: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        // edit profile function goes here, can add Save button on the bottom of the screen as well
    }
    

    

}
