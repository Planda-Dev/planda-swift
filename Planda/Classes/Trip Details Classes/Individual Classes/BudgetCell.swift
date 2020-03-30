//
//  BudgetCell.swift
//  Planda
//
//  Created by Prince Carter on 1/20/20.
//  Copyright © 2020 Prince Carter. All rights reserved.
//

import UIKit

class BudgetCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!

    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "BudgetTableCell", bundle: nil), forCellReuseIdentifier: "BudgetCell")
        tableView.register(UINib(nibName: "BudgetTableCellTwo", bundle: nil), forCellReuseIdentifier: "BudgetCellTwo")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "BudgetCell", for: indexPath)
            cell.backgroundColor = .clear
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BudgetCellTwo", for: indexPath)
            cell.backgroundColor = .clear
            return cell
        }
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0){
            return 350
        } else {
            return 230
        }
    }
    

        
}



