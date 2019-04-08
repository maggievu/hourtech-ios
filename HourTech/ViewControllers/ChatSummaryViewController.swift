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
        getMessages()
        
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
                let separateKey = eachKey.split(separator: "_")
                print("separateKey:\(separateKey)")
                
                if separateKey[0] == self.currentUserId || separateKey[1] == self.currentUserId {
                    print("User match!!")
                    let newChatSum = ChatSummary()
                    
                    self.channelId = eachKey
//                    GET Chat Summary <<<
                    messageDB.child(eachKey).observeSingleEvent(of: .value, with: { (Snapshot) in
                        print("DateTimeSnapshot: \(Snapshot)")
                        let channelDataDictionary = Snapshot.value as! [String: Any]
                        print("DataDictionary: >> \(channelDataDictionary)")
                        newChatSum.latestTime = channelDataDictionary["latestDateTime"] as! Double
                        print("LatestTime: \(newChatSum.latestTime)")
                        
                    })
                    
                    
                    if self.currentUserId == separateKey[0] {
                        self.databaseRef.child("users").child(String(separateKey[1])).observe(.value, with: { (userSnapshot) in
                            
                            let dataDictionary = userSnapshot.value as! [String: Any]
                            print("userSnapshot: \(userSnapshot)")
                            
                            newChatSum.chatChannelId = separateKey[0]+"_"+separateKey[1]
                            
                            newChatSum.firstname = dataDictionary["firstname"] as! String
                            
                            newChatSum.lastname = dataDictionary["lastname"] as! String
                            
                            newChatSum.title = dataDictionary["title"] as! String
                            
                            newChatSum.imageURL = dataDictionary["imgURL"] as! String
                            
                            self.chatSummary.append(newChatSum)
                            
                            self.messageSummaryTableView.reloadData()
                            
                            
                        })
                    } else {
                        self.databaseRef.child("users").child(String(separateKey[0])).observe(.value, with: { (userSnapshot) in
                            
                            let dataDictionary = userSnapshot.value as! [String: Any]
                            print("userSnapshot2: \(userSnapshot)")
                            
                            newChatSum.chatChannelId = separateKey[0]+"_"+separateKey[1]
                            
                            newChatSum.firstname = dataDictionary["firstname"] as! String
                            
                            newChatSum.lastname = dataDictionary["lastname"] as! String
                            
                            newChatSum.title = dataDictionary["title"] as! String
                            
                            newChatSum.imageURL = dataDictionary["imgURL"] as! String
                            
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
        return 100
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
