//
//  TechkyProfileTableViewCell.swift
//  HourTech
//
//  Created by Maggie on 2019-02-27.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit

class TechkyProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var techkyNameLabel: UILabel!
    @IBOutlet weak var techkyTitleLabel: UILabel!
    @IBOutlet weak var techkyDescriptionLabel: UILabel!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
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
    }

}
