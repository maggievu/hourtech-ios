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
    @IBOutlet weak var profileImageView: UIImageView!
    
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
            profileImageView.sd_setImage(with: URL(string: profile.profileURL!), placeholderImage: UIImage(named: "avatar"))
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
                chatSummary.latestTime = 0
                
                print("Sent_chatSummary: \(chatSummary)")
                chatDetailVC.chatDetail = chatSummary
            }
        }
    }
    
    @IBAction func contactButtonTapped(_ sender: Any) {
        print("currentUserId: \(currentUserId)")
        print("profile_UserID: \(profileUserId)")
        
        if Auth.auth().currentUser != nil {
            checkExistingChatChannel()
        } else {
            let alertController = UIAlertController(title: "Required Signing In", message: "Please sign in to contact Techky", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: { action in self.performSegue(withIdentifier: "signin_segue", sender: self) })
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
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
                        "content": "Hi there, How can I help you?",
                        "created": Int(NSDate().timeIntervalSince1970),
                        "senderId": profileUserId,
                        "senderName": profileName
                    ]
                ]
            ]
        ]
        
        chatRef.updateChildValues(channelItem)
        
        let channelRef = chatRef.child(channelId)
        
        let timeDictionary = [ "latestDateTime": Int(NSDate().timeIntervalSince1970)] as [String : Any]
        channelRef.updateChildValues(timeDictionary)
        
        print("Perform Segue After create Channel")
        performSegue(withIdentifier: "chatDetail_segue", sender: self)
    }
    
}
