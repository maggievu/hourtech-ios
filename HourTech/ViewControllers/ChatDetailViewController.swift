//
//  ChatDetailViewController.swift
//  HourTech
//
//  Created by Noppawit Hansompob on 28/3/2562 BE.
//  Copyright © 2562 Maggie VU. All rights reserved.
//

import UIKit
import MessageKit
import MessageInputBar
import Firebase

class ChatDetailViewController: MessagesViewController {
    
    var chatDetail: ChatSummary?
    
    var messages: [Message] = []
    var member: Member!
    var member2: Member!
    
    var channelId: String = ""
    
    var currentUserId: String = ""
    var currentUserName: String = ""
    var secondaryUserId: String = ""
    var secondaryUserName: String = ""
    var memberDictionary: [String: Member] = [:]
    
    
    let databaseRef = Database.database().reference()
    
    var currentMember: Member!
    var secondMember: Member!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ChannalId: \(chatDetail!.chatChannelId)")
        print("Passed-userId: \(chatDetail!.userId)")
        if Auth.auth().currentUser != nil {
            currentUserId = Auth.auth().currentUser!.uid
        }
        
        channelId = chatDetail!.chatChannelId
        
        
//        member = Member(name: "bluemoon", color: .blue)
        createMember()
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messageInputBar.delegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
//        messagesCollectionView.reloadData()
        
    }
    func createMember() {
        let memberIdArray = channelId.split(separator: "_")
        for eachUserId in memberIdArray {
            if eachUserId != currentUserId {
                secondaryUserId = String(eachUserId)
            }
        }
        print("currentUserId: \(currentUserId)")
        print("secondaryUserId: \(secondaryUserId)")
        
        databaseRef.child("users").child(currentUserId).observe(.value, with: { (userSnapshot) in
            
            let dataDictionary = userSnapshot.value as! [String: Any]
            print("userSnapshot: \(userSnapshot)")
            
            let firstname = dataDictionary["firstname"] as! String
            let lastname = dataDictionary["lastname"] as! String
        
            self.currentUserName = firstname + " " + lastname
            
            self.currentMember = Member(name: self.currentUserName, color: UIColor(red: 71/255.0, green: 143/255.0, blue: 204/255.0, alpha: 1))
            
            self.memberDictionary[self.currentUserId] = self.currentMember
            
            print("currentUserName: \(self.currentUserName)")
            print("memberDictionaryCurrentUser: \(String(describing: self.memberDictionary[self.currentUserId]))")
            if ( self.currentMember != nil && self.secondMember != nil ) {
//                self.hardCodeMessage()
                print("hardCode in CurrentMember")
                self.retrieveMessage()
                
                self.messagesCollectionView.reloadData()
            }
        })
        
        databaseRef.child("users").child(secondaryUserId).observe(.value, with: { (userSnapshot) in
            
            let dataDictionary = userSnapshot.value as! [String: Any]
            print("userSnapshot: \(userSnapshot)")
            
            let firstname = dataDictionary["firstname"] as! String
            let lastname = dataDictionary["lastname"] as! String
            
            self.secondaryUserName = firstname + " " + lastname
            
            self.secondMember = Member(name: self.secondaryUserName, color: .lightGray)
            
            self.memberDictionary[self.secondaryUserId] = self.secondMember
            
            print("secondaryUserName: \(self.secondaryUserName)")
            print("memberDictionaryUser2: \(String(describing: self.memberDictionary[self.secondaryUserId]))")
            if ( self.currentMember != nil && self.secondMember != nil ) {
//                self.hardCodeMessage()
                print("hardCode in SecondMember")
                self.retrieveMessage()
                
                self.messagesCollectionView.reloadData()
            }
            
        })
//        currentMember = Member(name: currentUserName, color: .blue)
//        secondMember = Member(name: secondaryUserName, color: .green)
    }
    
    func hardCodeMessage(){
//        member = Member(name: "bluemoon", color: .blue)
//        member2 = Member(name: "greenboy", color: .green)
        
        let newMessage1 = Message(
            member: currentMember,
            text: "Hello there",
            messageId: UUID().uuidString)
        
        messages.append(newMessage1)
        
        let newMessage2 = Message(
            member: secondMember,
            text: "Good morning, how can I help you today?",
            messageId: UUID().uuidString)
        
        messages.append(newMessage2)
        
        let newMessage3 = Message(
            member: currentMember,
            text: "I'd like to deploy a React project on AWS",
            messageId: UUID().uuidString)
        
        messages.append(newMessage3)
        
        let newMessage4 = Message(
            member: currentMember,
            text: "Sure. I can install HTTPS for your DNS too",
            messageId: UUID().uuidString)
        
        messages.append(newMessage4)
        
        messagesCollectionView.reloadData()
    }
    
    //MARK: Insert into Firebase Database
    
    func insertIntoFirebase(newMessage: Message) {
        print("newMessage: \(newMessage)")
        let chatsRef = databaseRef.child("chats")
        
        let messageDictionary = [   "content": newMessage.text,
                                    "created": Int(NSDate().timeIntervalSince1970),
                                    "senderId": currentUserId,
                                    "senderName": currentUserName   ] as [String : Any]
        
        let channelRef = chatsRef.child(channelId)
        
        let timeDictionary = [ "latestDateTime": Int(NSDate().timeIntervalSince1970)] as [String : Any]
        channelRef.updateChildValues(timeDictionary)
        
        let threadRef = channelRef.child("thread")
        threadRef.childByAutoId().setValue(messageDictionary) {
            (error, reference) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                print("Message Submit")
            }
        }
    }
    
    func retrieveMessage() {
        let chatsRef = databaseRef.child("chats").child(channelId).child("thread")
        
        chatsRef.queryOrdered(byChild: "created").observe(.value) { (messageSnapshot) in
//            print("messageSnapshot: \(messageSnapshot)")
            self.messages = []
            for eachMessage in messageSnapshot.children {
                print("eachChatMessage: \(eachMessage)")
                let snap = eachMessage as! DataSnapshot
                let dataDictionary = snap.value as! [String: Any]
                
                let newChatMessage = Message(
                    member: self.memberDictionary[dataDictionary["senderId"] as! String]!,
                    text: dataDictionary["content"] as! String,
                    messageId: UUID().uuidString
                )
                print("newChatMessage: \(newChatMessage)")
                self.messages.append(newChatMessage)
                self.messagesCollectionView.reloadData()
                
            }
        }
    }

}
extension ChatDetailViewController: MessagesDataSource {
    func numberOfSections(
        in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func currentSender() -> Sender {
        return Sender(id: currentMember.name, displayName: currentMember.name)
    }
    
    func messageForItem( at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return messages[indexPath.section]
    }
    
    func messageTopLabelHeight(
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) -> CGFloat {

        return 12
    }
    
//    func messageTopLabelAttributedText(
//        for message: MessageType,
//        at indexPath: IndexPath) -> NSAttributedString? {
//
//        return NSAttributedString(
//            string: message.sender.displayName,
//            attributes: [.font: UIFont.systemFont(ofSize: 12)])
//    }
    func messageTopLabelAttributedText(for message: MessageType,
                                    at indexPath: IndexPath) -> NSAttributedString? {
        
        let name = message.sender.displayName
        return NSAttributedString(
            string: name,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: UIColor(white: 0.3, alpha: 1)
            ]
        )
    }
}

extension ChatDetailViewController: MessagesLayoutDelegate {
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath,
                    in messagesCollectionView: MessagesCollectionView) -> CGSize {

        return .zero
    }
    
    func footerViewSize(for message: MessageType, at indexPath: IndexPath,
                        in messagesCollectionView: MessagesCollectionView) -> CGSize {
        
        return CGSize(width: 0, height: 8)
    }
    
    
    func heightForLocation(message: MessageType,
                           at indexPath: IndexPath,
                           with maxWidth: CGFloat,
                           in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 0
    }
}

extension ChatDetailViewController: MessagesDisplayDelegate {
    func configureAvatarView(
        _ avatarView: AvatarView,
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) {

        
//        Avatar color setup
        let message = messages[indexPath.section]
        let color = message.member.color
        avatarView.backgroundColor = color
    }
    func backgroundColor(for message: MessageType, at indexPath: IndexPath,
                         in messagesCollectionView: MessagesCollectionView) -> UIColor {
        
        return isFromCurrentSender(message: message) ? UIColor(red: 71/255.0, green: 143/255.0, blue: 204/255.0, alpha: 1) : .lightGray
    }
    
    func shouldDisplayHeader(for message: MessageType, at indexPath: IndexPath,
                             in messagesCollectionView: MessagesCollectionView) -> Bool {
        
        return false
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath,
                      in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        
        return .bubbleTail(corner, .curved)
    }
}

extension ChatDetailViewController: MessageInputBarDelegate {
    func messageInputBar(
        _ inputBar: MessageInputBar,
        didPressSendButtonWith text: String) {
        
        let newMessage = Message(
            member: currentMember,
            text: text,
            messageId: UUID().uuidString)
        
        insertIntoFirebase(newMessage: newMessage)
        
//        messages.append(newMessage)
        inputBar.inputTextView.text = ""
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
}
