//
//  SearchResultsViewController.swift
//  HourTech
//
//  Created by Maggie on 2019-02-27.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import UIKit
import CoreData

class SearchResultsViewController: UIViewController {
    
//    var techkyProfiles = TechkyProfile.createProfile()
    var techkyProfiles = [Techky_Profile]()

    @IBOutlet weak var additionalNavigationBackground: UILabel!
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var searchStatusLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchKeywordFromHome = ""
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        
        self.dismissKeyboardOnTap()
        searchStatusLabel.text = ""
        
//        searchTableView.rowHeight = UITableView.automaticDimension
//        searchTableView.estimatedRowHeight = 500
        
        
        //MARK - Uncomment hardcodeProfile for the first time run after finished come back and comment it again since it is hardcoding.
//        hardcodeProfile()
        print("viewDidLoad: \(searchKeywordFromHome)")
        
        if let tabBarVC = self.tabBarController as? RootTabBarController {
            searchKeywordFromHome = tabBarVC.searchKeyword
            searchBar.text = searchKeywordFromHome
//          print("InsideClosureDidLoad: \(searchKeywordFromHome)")
        }
        loadSearchResult()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        
        searchBar(self.searchBar, textDidChange: searchKeywordFromHome)
//        print("OutsideClosure: \(searchKeywordFromHome)")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "techky_profile_segue" {
            let dvc = segue.destination as! TechkyProfileViewController
            dvc.profile = techkyProfiles[searchTableView.indexPathForSelectedRow!.row]
        }
    }
    
    func hardcodeProfile() {
        
        let newProfile1 = Techky_Profile(context: context)
        newProfile1.firstname = "Maggie"
        newProfile1.lastname = "Vu"
        newProfile1.title = "Developer"
        newProfile1.profile_description = "Highly motivated bla bla bla bla"
        techkyProfiles.append(newProfile1)
        
        let newProfile2 = Techky_Profile(context: context)
        newProfile2.firstname = "Diego"
        newProfile2.lastname = "Rodrigues De Oliveira"
        newProfile2.title = "Developer"
        newProfile2.profile_description = "Skillful, hard-working. 2-year student at Langara. Available for design, presentation, logo design..."
        techkyProfiles.append(newProfile2)
        
        let newProfile3 = Techky_Profile(context: context)
        newProfile3.firstname = "Noppawit"
        newProfile3.lastname = "Hansompob"
        newProfile3.title = "Developer"
        newProfile3.profile_description = "Skillful, hard-working. 2-year student at Langara. Available for design, presentation, logo design..."
        techkyProfiles.append(newProfile3)
        
        let newProfile4 = Techky_Profile(context: context)
        newProfile4.firstname = "Andra"
        newProfile4.lastname = "Iskandar"
        newProfile4.title = "Developer"
        newProfile4.profile_description = "Skillful, hard-working. 2-year student at Langara. Available for design, presentation, logo design..."
        techkyProfiles.append(newProfile4)
        
        let newProfile5 = Techky_Profile(context: context)
        newProfile5.firstname = "Julia"
        newProfile5.lastname = "Stanovsky"
        newProfile5.title = "Designer"
        newProfile5.profile_description = "Skillful, hard-working. 2-year student at Langara. Available for design, presentation, logo design..."
        techkyProfiles.append(newProfile5)
        
        saveProfile()
    }
    
    func saveProfile() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        searchTableView.reloadData()
    }
    
    func loadSearchResult(with request: NSFetchRequest<Techky_Profile> = Techky_Profile.fetchRequest()) {
        do {
            techkyProfiles = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        updateStatusLabel(count: techkyProfiles.count)
        
        searchTableView.reloadData()
    }
    
    func updateStatusLabel(count: Int) {
        if count == 0 {
            searchStatusLabel.text = "No result found for \"\(searchBar.text!)\""
        } else if count < 2 {
            searchStatusLabel.text = "\(count) result found for \"\(searchBar.text!)\""
        } else {
            searchStatusLabel.text = "\(count) results found for \"\(searchBar.text!)\""
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
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        searchKeywordFromHome = searchBar.text!
//        print("didSelectRowAt: \(searchKeywordFromHome)")
        
        performSegue(withIdentifier: "techky_profile_segue", sender: self)
        
    }
    
}

extension SearchResultsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Techky_Profile> = Techky_Profile.fetchRequest()
        
        request.predicate = NSPredicate(format: "skill CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "skill", ascending: true)]
        
        loadSearchResult(with: request)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadSearchResult()
            
            searchStatusLabel.text = ""
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        } else {
            
            let request : NSFetchRequest<Techky_Profile> = Techky_Profile.fetchRequest()
            
            request.predicate = NSPredicate(format: "skill CONTAINS[cd] %@", searchBar.text!)
            
            request.sortDescriptors = [NSSortDescriptor(key: "skill", ascending: true)]
            
            loadSearchResult(with: request)
            
        }
    }
}
