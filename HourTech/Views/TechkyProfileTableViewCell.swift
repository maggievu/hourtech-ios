//
//  TechkyProfileTableViewCell.swift
//  HourTech
//
//  Created by Maggie on 2019-02-27.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit
import SDWebImage

class TechkyProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var techkyNameLabel: UILabel!
    @IBOutlet weak var techkyTitleLabel: UILabel!
    @IBOutlet weak var techkyDescriptionLabel: UILabel!
    @IBOutlet weak var techkyImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        techkyNameLabel.text = ""
        techkyTitleLabel.text = ""
        techkyDescriptionLabel.text = ""
    }
    
    func configurateCell(_ profile: Techky_Profile) {
        techkyNameLabel.text = profile.firstname! + " " + profile.lastname!
        techkyTitleLabel.text = profile.title
        techkyDescriptionLabel.text = profile.profile_description
        techkyImageView.sd_setImage(with: URL(string: profile.profileURL!), placeholderImage: UIImage(named: "avatar"))
    }

}
