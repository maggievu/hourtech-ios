//
//  SeachOutputViewController.swift
//  HourTech
//
//  Created by Noppawit Hansompob on 27/2/2562 BE.
//  Copyright © 2562 Maggie VU. All rights reserved.
//

import UIKit
import Firebase

class SeachOutputViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profileNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if Auth.auth().currentUser != nil {
            print("User signed in")
            let user = Auth.auth().currentUser
            if let user = user {
                let uid = user.uid
                let email = user.email
                
                profileNameLabel.text = "\(email!) \(uid)"
            }
        } else {
            print("No user Signed in")
            profileNameLabel.text = "Guest user"
        }
    }

    @IBAction func logOutButtonTapped(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("error: cannot signing out")
        }
        
        guard (navigationController?.popToRootViewController(animated: true)) != nil
            else {
                print("no view controller to pop off")
                return
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
