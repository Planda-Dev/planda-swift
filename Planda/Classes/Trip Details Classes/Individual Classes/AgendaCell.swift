//
//  AgendaCell.swift
//  Planda
//
//  Created by Prince Carter on 1/21/20.
//  Copyright © 2020 Prince Carter. All rights reserved.
//

import UIKit

class AgendaCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView.register(UINib(nibName: "AgendaTableCell", bundle: nil), forCellReuseIdentifier: "AgendaCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 230
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.insetsContentViewsToSafeArea = false
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaCell", for: indexPath)
        cell.backgroundColor = .clear
        return cell
    }

}
