//
//  SideMenuViewController.swift
//  HourTech
//
//  Created by Noppawit Hansompob on 15/3/2562 BE.
//  Copyright © 2562 Maggie VU. All rights reserved.
//

import UIKit
import Firebase

class SideMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func logoutButtonTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        guard (navigationController?.popToRootViewController(animated: true)) != nil
            else {
                print("No ViewController to pop")
                return
        }
    }
}
