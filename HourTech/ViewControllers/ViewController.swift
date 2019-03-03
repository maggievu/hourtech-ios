//
//  ViewController.swift
//  HourTech
//
//  Created by Maggie on 2019-02-25.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var gradient: CAGradientLayer!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.dismissKeyboardOnTap()
        
        view.addBackground()

        
        gradient = CAGradientLayer()
        gradient.frame = view.bounds
//        gradient.frame = UIScreen.main.bounds
        gradient.colors = [UIColor.blue.cgColor, UIColor.cyan.cgColor]
        gradient.locations = [0, 1]
//        view.layer.addSublayer(gradient)
        
//        let gradient = BackgroundCAGradientLayer(start: .topLeft, end: .bottomRight, colors: [UIColor.black.cgColor, UIColor.white.cgColor], type: .axial)
//
//        gradient.frame = view.bounds
//        view.layer.addSublayer(gradient)
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
}

