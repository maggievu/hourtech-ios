//
//  RootTabBarController.swift
//  HourTech
//
//  Created by Maggie Vu on 2019-03-02.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
    
    var searchKeyword = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 2
        
        print("tabBar SearchKeyWord: \(searchKeyword)")
    }
    
}
