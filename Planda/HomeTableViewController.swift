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
//        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
//        navigationController?.navigationBar.setBackgroundImage(img!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0 ,right: 0), resizingMode: .stretch), for: .defaultPrompt)
//        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let imageView = UIImageView(image: img)
        navigationController?.navigationItem.titleView = imageView
        

        
        // Search Bar Setup
        let searchBar = UISearchBar()
        searchBar.placeholder = "Explore with Planda"
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.searchBarStyle = .prominent
        
        // TextField Color Customization
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.black
        
        // Placeholder Customization
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor.black
        
        // Glass Icon Customization
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = UIColor.black
        
    }
    
    // MARK: - Table view data source
    
    // TABLEVIEW NUMBER OF SECTIONS
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // TABLEVIEW NUMBER OF ROWS IN EACH SECTION
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    // TABLEVIEW HEADERS
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 40))
        label.font = UIFont.boldSystemFont(ofSize: 30)
                if section == 0 {
            label.text = " Popular"
        } else {
            label.text = " Recommended"
        }
        view.addSubview(label)
        view.backgroundColor = UIColor.white

        return view
    }
    
    // TABLEVIEW HEADER HEIGHT
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    // SET TABLEVIEW ROW HEIGHT AND DEQUEUE TABLE CELLS
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            tableView.rowHeight = 270
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath)
            return cell
        } else {
            // Adjust TableView
            tableView.rowHeight = 500
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecCell", for: indexPath)
            return cell
        }
    }
    
}
