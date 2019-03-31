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
    
    var profileName: String = ""
    
    var channelIdArray = [String]()
    var channelId: String = ""
    var channelFlag: Bool = false
    
    let chatSummary: ChatSummary = ChatSummary()
    
    let databaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let profile = profile {
            profileName = profile.firstname! + " " + profile.lastname!
            nameLabel.text = profileName
            titleLabel.text = profile.title
            descriptionLabel.text = profile.profile_description
            profileUserId = profile.userId!
        }
        
        if Auth.auth().currentUser != nil {
            currentUserId = Auth.auth().currentUser!.uid
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chatDetail_segue" {
            if let chatDetailVC = segue.destination as? ChatDetailViewController{
                
                chatSummary.chatChannelId = channelId
                chatSummary.firstname = (profile?.firstname!)!
                chatSummary.lastname = (profile?.lastname!)!
                chatSummary.userId = profileUserId
                chatSummary.fullname = profileName
                chatSummary.title = (profile?.title!)!
                chatSummary.latestTime = " "
                
                print("Sent_chatSummary: \(chatSummary)")
                chatDetailVC.chatDetail = chatSummary
            }
        }
    }
    
    @IBAction func contactButtonTapped(_ sender: Any) {
        print("currentUserId: \(currentUserId)")
        print("profile_UserID: \(profileUserId)")
        
        checkExistingChatChannel()
        
    }
    
    func checkExistingChatChannel() {
        let possibleKey1 = currentUserId + "_" + profileUserId
        channelIdArray.append(possibleKey1)
        let possibleKey2 = profileUserId + "_" + currentUserId
        channelIdArray.append(possibleKey2)
        
        databaseRef.child("chats").observeSingleEvent(of: .value, with: { (chatChannelSnapshot) in
            for eachPossiblekey in self.channelIdArray {
                if chatChannelSnapshot.hasChild(eachPossiblekey) {
                    self.channelId = eachPossiblekey
                    self.channelFlag = true
                    
                    break
                } else {
                    self.channelId = possibleKey1
                    self.channelFlag = false
                }
            }
            print("channelId: \(self.channelId)");
            
            if !self.channelFlag {
                self.createNewChannel()
            } else {
                print("Perform Segue in ELSE")
                self.performSegue(withIdentifier: "chatDetail_segue", sender: self)
            }
            
        })
    }
    
    func createNewChannel() {
        let chatRef = databaseRef.child("chats")
        
        let channelItem = [
            channelId : [
                "thread": [
                    "ChatID-00":[
                        "content": "Hello there, Welcome to private chat.",
                        "created": Int(NSDate().timeIntervalSince1970),
                        "senderId": profileUserId,
                        "senderName": profileName
                    ]
                ]
            ]
        ]
        
        chatRef.updateChildValues(channelItem)
        print("Perform Segue After create Channel")
        performSegue(withIdentifier: "chatDetail_segue", sender: self)
    }
    
}
