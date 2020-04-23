//
//  HomeTableViewController.swift
//  Planda
//
//  Created by Prince Carter on 4/23/20.
//  Copyright © 2020 Planda. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar Setup
        let img = UIImage(named: "venicebeach")
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        navigationController?.setBackgroundImage(img!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0 ,right: 0), resizingMode: .stretch))
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        // Search Bar Setup
        let searchBar = UISearchBar()
        searchBar.placeholder = "Explore with Planda"
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.searchBarStyle = .prominent
        
        // TextField Color Customization
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        
        // Placeholder Customization
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor.white
        
        // Glass Icon Customization
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = UIColor.white
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        if section == 0 {
            label.text = " Popular"
        } else {
            label.text = " Recommended"
        }
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 26)
        return label
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            tableView.rowHeight = 250
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath)
            return cell
        } else {
            // Adjust TableView
            tableView.rowHeight = 390
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecCell", for: indexPath)

            return cell
        }
    }
}

extension HomeTableViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let height = 300.0
        return CGFloat(height)
    }
}
