//
//  PhotoInfoController.swift
//  Papers
//
//  Created by Don Bytyqi on 5/6/17.
//  Copyright © 2017 Don Bytyqi. All rights reserved.
//

import UIKit

class PhotoInfoController: UIViewController {
    
    let photoViewer = PhotoViewer(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        
        view = photoViewer
        navigationController?.navigationBar.isHidden = true
        UIApplication.shared.isStatusBarHidden = true
        photoViewer.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UIApplication.shared.isStatusBarHidden = false
        navigationController?.navigationBar.isHidden = false
    }
    
    func handlePortofolio() {
        //later...
    }
    
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
}
