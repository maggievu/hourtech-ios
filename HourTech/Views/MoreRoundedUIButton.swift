//
//  MoreRoundedUIButton.swift
//  HourTech
//
//  Created by Maggie on 2019-03-04.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit

class MoreRoundedUIButton: UIButton {

    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
    
}
