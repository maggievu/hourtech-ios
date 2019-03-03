//
//  RoundedCornerUIButton.swift
//  HourTech
//
//  Created by Maggie on 2019-03-03.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit

class RoundedCornerUIButton: UIButton {

    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

}
