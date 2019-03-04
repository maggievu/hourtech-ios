//
//  TechkyProfileViewController.swift
//  HourTech
//
//  Created by Maggie on 2019-02-27.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import Foundation
import UIKit

class TechkyProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var profile: Techky_Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let profile = profile {
            nameLabel.text = profile.firstname! + " " + profile.lastname!
            titleLabel.text = profile.title
            descriptionLabel.text = profile.profile_description
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
