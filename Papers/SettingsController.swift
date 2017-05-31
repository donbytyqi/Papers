//
//  SettingsController.swift
//  Papers
//
//  Created by Don Bytyqi on 5/7/17.
//  Copyright © 2017 Don Bytyqi. All rights reserved.
//

import UIKit

protocol PhotoQualityDelegate {
    func photo(withQuality: String)
}


class SettingsController: UITableViewController {
    
    static let cellId = "cellId"
    
    var c: UITableViewCell?
    
    var photoQualityDelegate: PhotoQualityDelegate?
    
    let switchQuality: UISwitch = {
        let sq = UISwitch()
        sq.translatesAutoresizingMaskIntoConstraints = false
        sq.isOn = false
        return sq
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Settings"
        
        c = UITableViewCell(style: .subtitle, reuseIdentifier: SettingsController.cellId)
        c?.accessoryType = .none
        c?.textLabel?.text = "Raw Photos"
        c?.detailTextLabel?.text = "Enable this for raw high quality photos."
        
        c?.addSubview(switchQuality)
        
        switchQuality.centerYAnchor.constraint(equalTo: (c?.centerYAnchor)!).isActive = true
        switchQuality.rightAnchor.constraint(equalTo: (c?.rightAnchor)!, constant: -10).isActive = true
        
        switchQuality.addTarget(self, action: #selector(changePhotoQuality), for: .valueChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if UserDefaults.standard.bool(forKey: "switch") == true {
            switchQuality.isOn = true
        }
        else {
            switchQuality.isOn = false
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return c!
    }
    
    func changePhotoQuality(sender: UISwitch) {
        
        if sender.isOn == true {
            
            if photoQualityDelegate != nil {
                photoQualityDelegate?.photo(withQuality: "raw")
                UserDefaults.standard.set(true, forKey: "switch")
                UserDefaults.standard.synchronize()
                
                
            }
        }
        else {
            if photoQualityDelegate != nil {
                photoQualityDelegate?.photo(withQuality: "regular")
                UserDefaults.standard.set(false, forKey: "switch")
                UserDefaults.standard.synchronize()
                
                
            }
        }
    }
    
}
