//
//  RootTabBarController.swift
//  HourTech
//
//  Created by London Drugs on 2019-03-02.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
    
    var searchKeyword = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 2
        
        print("tabBar SearchKeyWord: \(searchKeyword)")

//        tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
//    tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.clear], for: .selected)
//    tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.clear], for: .normal)
    }
    
}
