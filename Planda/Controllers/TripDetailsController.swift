//
//  TripDetailsController.swift
//  Planda
//
//  Created by Prince Carter on 12/31/19.
//  Copyright © 2019 Prince Carter. All rights reserved.
//

import UIKit

class TripDetailsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "South Africa"
        self.tableView.separatorStyle = .none
        let nib = UINib.init(nibName: "Details_TripHeaderCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "Details_TripHeaderCell")
        
        let nib2 = UINib.init(nibName: "Details_MenuBar", bundle: nil)
        self.tableView.register(nib2, forCellReuseIdentifier: "Details_MenuBar")
        
        let nib3 = UINib.init(nibName: "Details_TripBudgetCell", bundle: nil)
        self.tableView.register(nib3, forCellReuseIdentifier: "Details_TripBudgetCell")
        
        let nib4 = UINib.init(nibName: "Details_TripPhotosCell", bundle: nil)
        self.tableView.register(nib4, forCellReuseIdentifier: "Details_TripPhotosCell")
        
        let nib5 = UINib.init(nibName: "Details_TripGroupCell", bundle: nil)
        self.tableView.register(nib5, forCellReuseIdentifier: "Details_TripGroupCell")
        
        let nib6 = UINib.init(nibName: "PagingTableViewCell", bundle: nil)
        self.tableView.register(nib6, forCellReuseIdentifier: "PagingCell")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0){
            self.tableView.rowHeight = 200
            let cell = tableView.dequeueReusableCell(withIdentifier: "Details_TripHeaderCell", for: indexPath)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        
        self.tableView.rowHeight = UIScreen.main.bounds.height
        let cell = tableView.dequeueReusableCell(withIdentifier: "PagingCell", for: indexPath)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.backgroundColor = .red
        return cell
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
