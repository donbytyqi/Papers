//
//  SettingsController.swift
//  Papers
//
//  Created by Don Bytyqi on 5/7/17.
//  Copyright © 2017 Don Bytyqi. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController {
    
    static let cellId = "cellId"
    
    var c: UITableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Settings"
        
        c = UITableViewCell(style: .subtitle, reuseIdentifier: SettingsController.cellId)
        c?.accessoryType = .disclosureIndicator
        c?.textLabel?.text = "Remove Ads"
        c?.detailTextLabel?.text = "$1.99"
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            buyProduct()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return c!
    }
    
    func buyProduct() {
        self.showAlert(title: "Oops", message: "Not implemented yet")
    }
    
}
