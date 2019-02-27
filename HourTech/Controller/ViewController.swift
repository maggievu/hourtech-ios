//
//  ViewController.swift
//  HourTech
//
//  Created by Maggie on 2019-02-25.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toLogin", sender: self)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: self)
    }
    @IBAction func searchButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toSearch", sender: self)
    }
}

