//
//  SearchResultsViewController.swift
//  HourTech
//
//  Created by Maggie on 2019-02-27.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    var techkyProfiles = TechkyProfile.createProfile()

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var additionalNavigationBackground: UILabel!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHideKeyboardOnTap()
        
//        searchTableView.rowHeight = UITableView.automaticDimension
//        searchTableView.estimatedRowHeight = 500

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "techky_profile_segue" {
            let dvc = segue.destination as! TechkyProfileViewController
            dvc.profile = techkyProfiles[searchTableView.indexPathForSelectedRow!.row]
        }
    }

}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return techkyProfiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as? TechkyProfileTableViewCell {
            cell.configurateCell(techkyProfiles[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "techky_profile_segue", sender: self)
    }
    
}
