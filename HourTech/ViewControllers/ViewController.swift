//
//  ViewController.swift
//  HourTech
//
//  Created by Maggie on 2019-02-25.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    private var gradient: CAGradientLayer!
    let duration:Double = 1.0
    let delay:Double = 0
    
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
    
}

