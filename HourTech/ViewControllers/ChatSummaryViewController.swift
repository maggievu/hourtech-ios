//
//  ChatSummaryViewController.swift
//  HourTech
//
//  Created by Noppawit Hansompob on 25/3/2562 BE.
//  Copyright © 2562 Maggie VU. All rights reserved.
//

import UIKit
import Firebase

class ChatSummaryViewController: UIViewController {
    
    var currentUserId: String = ""
    var chatSummary = [ChatSummary]()
    let databaseRef = Database.database().reference()
    
    var channelId: String = ""

    @IBOutlet weak var messageSummaryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            currentUserId = Auth.auth().currentUser!.uid
        }
        
//        hardCodeSummary()
        getMessages()
        
    }
    
    func hardCodeSummary() {
        let chat1 = ChatSummary()
        chat1.firstname = "Albert"
        chat1.lastname = "Gilmore"
        chat1.title = "Client"
        chatSummary.append(chat1)
        
        let chat2 = ChatSummary()
        chat2.firstname = "Samantra"
        chat2.lastname = "Jackson"
        chat2.title = "Designer"
        chatSummary.append(chat2)
    }
    
    func getMessages() {
        let messageDB = databaseRef.child("chats")
        print("messageDB \(messageDB)")
        
        messageDB.observeSingleEvent(of: .value, with: { (snapshot) in
            print("key: \((snapshot.value as AnyObject).allKeys!)")
            print("AllChatSnapshot: >> \(snapshot.value as AnyObject)")
            let allChatId = (snapshot.value as AnyObject).allKeys!
            for eachKey in allChatId as! [String] {
                print("eachKey: \(eachKey)")
                let saperateKey = eachKey.split(separator: "_")
                print("saperateKey:\(saperateKey)")
                
                if saperateKey[0] == self.currentUserId || saperateKey[1] == self.currentUserId {
                    print("User match!!")
                    let newChatSum = ChatSummary()
                    
                    self.channelId = eachKey
                    messageDB.child(eachKey).observeSingleEvent(of: .value, with: { (Snapshot) in
                        print("DateTimeSnapshot: \(Snapshot)")
                        let channelDataDictionary = Snapshot.value as! [String: Any]
                        print("DataDitionary: >> \(channelDataDictionary)")
                        newChatSum.latestTime = channelDataDictionary["latestDateTime"] as! Double
                        print("LatestTime: \(newChatSum.latestTime)")
                        
                    })
                    
                    
                    if self.currentUserId == saperateKey[0] {
                        self.databaseRef.child("users").child(String(saperateKey[1])).observe(.value, with: { (userSnapshot) in
                            //
                            let dataDictionary = userSnapshot.value as! [String: Any]
                            print("userSnapshot: \(userSnapshot)")
                            
                            
                            
                            newChatSum.chatChannelId = saperateKey[0]+"_"+saperateKey[1]
                            
                            newChatSum.firstname = dataDictionary["firstname"] as! String
                            
                            newChatSum.lastname = dataDictionary["lastname"] as! String
                            
                            newChatSum.title = dataDictionary["title"] as! String
                            //                            newChatSum.userId = dataDictionary["userId"] as! String
                            
                            self.chatSummary.append(newChatSum)
                            
                            self.messageSummaryTableView.reloadData()
                            
                            
                        })
                    } else {
                        self.databaseRef.child("users").child(String(saperateKey[0])).observe(.value, with: { (userSnapshot) in
                            
                            let dataDictionary = userSnapshot.value as! [String: Any]
                            print("userSnapshot2: \(userSnapshot)")
                            
//                            let newChatSum = ChatSummary()
                            
                            newChatSum.chatChannelId = saperateKey[0]+"_"+saperateKey[1]
                            
                            newChatSum.firstname = dataDictionary["firstname"] as! String
                            
                            newChatSum.lastname = dataDictionary["lastname"] as! String
                            
                            newChatSum.title = dataDictionary["title"] as! String
                            //                            newChatSum.imgURL= dataDictionary["imgURL"] as! String
                            
                            self.chatSummary.append(newChatSum)
                            
                            self.messageSummaryTableView.reloadData()
                            
                        })
                    }
                } else {
                    print("No related Chat")
                }
            }
            print("chatSummary: \(self.chatSummary)")
        })
        
    }

}

extension ChatSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("chatCount: \(chatSummary.count)")
        return chatSummary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatSummaryCell", for: indexPath) as? MessageSummaryTableViewCell {
            cell.configurateCell(chatSummary[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "chatDetail_segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chatDetail_segue" {
            if let chatDetailVC = segue.destination as? ChatDetailViewController{
                print("SelectedChannelInfo: \(chatSummary[messageSummaryTableView.indexPathForSelectedRow!.row])")
                chatDetailVC.chatDetail = chatSummary[messageSummaryTableView.indexPathForSelectedRow!.row]
            }
        }
    }
}
