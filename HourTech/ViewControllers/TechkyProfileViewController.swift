//
//  TechkyProfileViewController.swift
//  HourTech
//
//  Created by Maggie on 2019-02-27.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class TechkyProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var profile: Techky_Profile?
    
    var currentUserId: String = ""
    var profileUserId: String = ""
    
    var channelIdArray = [String]()
    var channelId: String = ""
    
    let databaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let profile = profile {
            nameLabel.text = profile.firstname! + " " + profile.lastname!
            titleLabel.text = profile.title
            descriptionLabel.text = profile.profile_description
            profileUserId = profile.userId!
        }
        
        if Auth.auth().currentUser != nil {
            currentUserId = Auth.auth().currentUser!.uid
        }

    }
    @IBAction func contactButtonTapped(_ sender: Any) {
//        print("profile:>>> \(String(describing: profile))")
        print("currentUserId: \(currentUserId)")
        print("profile_UserID: \(profileUserId)")
        
        checkExistingChatChannel()
        
    }
    
    func checkExistingChatChannel() {
        let possibleKey1 = currentUserId + "_" + profileUserId
        channelIdArray.append(possibleKey1)
        let possibleKey2 = profileUserId + "_" + currentUserId
        channelIdArray.append(possibleKey2)
        
//        let chatsRef = databaseRef.child("chats").child(channelId).child("thread")
        databaseRef.child("chats").observe(.value) { (chatChannelSnapshot) in
            for eachPossiblekey in self.channelIdArray {
                if chatChannelSnapshot.hasChild(eachPossiblekey) {
                    self.channelId = eachPossiblekey
                    break
                } else {
                    self.channelId = possibleKey1
                }
            }
            print("channelId: \(self.channelId)");
            
        }
    }
    
    func createNewChannel() {
        
    }
    
}
