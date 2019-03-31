//
//  ViewController.swift
//  HourTech
//
//  Created by Maggie on 2019-02-25.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class ViewController: UIViewController, UITextFieldDelegate {

    private var gradient: CAGradientLayer!
    let duration:Double = 1.0
    let delay:Double = 0
    
    let defaults = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var techkyProfiles = [Techky_Profile]()
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchInstructionLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var searchButtonLabel: RoundedCornerUIButton!
    @IBOutlet weak var searchIconLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.dismissKeyboardOnTap()
        
        searchTextField.delegate = self
        
        view.addBackground()
        
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.moveUp(view: self.logoImageView)
        }, completion: nil)
        
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
            self.showFade(view: self.searchInstructionLabel)
            self.showFade(view: self.searchTextField)
            self.showFade(view: self.searchButtonLabel)
            self.showFade(view: self.searchIconLabel)
      }, completion: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        retrieveProfile()
        print("ViewDidLoad")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func searchIconTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "search_segue", sender: self)
    }
    
    @IBAction func searchTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "search_segue", sender: self)
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "signin_segue", sender: self)
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "signup_segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search_segue" {
            if let tabBarVC = segue.destination as? RootTabBarController{
            
                tabBarVC.searchKeyword = searchTextField.text!
            }
        }
    }
    
    func moveUp(view: UIView) {
//        view.transform.translatedBy(x: 0, y: -350)
        view.frame.size.height -= 350
        view.transform = CGAffineTransform(translationX: 0.0, y: -200)
//        view.transform = CGAffineTransform(scaleX: 0.55, y: 0.55)
    }
    
    func showFade(view: UIView){
        view.alpha = 1.0
        view.transform = CGAffineTransform(translationX: 0.0, y: -50)
        view.frame.size.height -= 350
    }
    
    func retrieveProfile() {
        let profileDB = Database.database().reference().child("profiles")
        print("profileDB \(profileDB)")
        
        profileDB.observe(.value, with: { (snapshot) in
            
            print("snapshot:  \(snapshot)")
            
            for child in snapshot.children {
//                print("Child:  \(child)")
                let snap = child as! DataSnapshot
                let dataDictionary = snap.value as! [String: Any]

                let newProfile = Techky_Profile(context: self.context)

                newProfile.firstname = dataDictionary["firstname"] as? String
                newProfile.lastname = dataDictionary["lastname"] as? String
                newProfile.profile_description = dataDictionary["description"] as? String
                newProfile.skill = dataDictionary["skill"] as? String
                newProfile.title = dataDictionary["title"] as? String
                newProfile.userId = dataDictionary["userId"] as? String
                
                self.techkyProfiles.append(newProfile)
            }
            print("techkyProfiles: \(self.techkyProfiles)")
            print("ChildrenCount: \(snapshot.childrenCount)")

            self.deleteAllData("Techky_Profile")
            
            self.saveProfile()
        })
    }
    
    func saveProfile() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func deleteAllData(_ entity:String) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        print("Keyboard will show: \(notification.name.rawValue)")
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        performSegue(withIdentifier: "search_segue", sender: self)
        searchTextField.resignFirstResponder()
        return true
    }
    
}

