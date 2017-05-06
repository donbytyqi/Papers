//
//  PhotoInfoController.swift
//  Papers
//
//  Created by Don Bytyqi on 5/6/17.
//  Copyright © 2017 Don Bytyqi. All rights reserved.
//

import UIKit

class PhotoInfoController: UIViewController {
    
    var photo: Photo? {
        didSet {
            // "regular" or "raw" for better quality
            if let photoImageUrl = photo?.urls?["regular"] {
                photoImageView.downloadImageFrom(urlString: photoImageUrl)
            }
        }
    }
    
    let photoImageView: PhotoImage = {
        let piv = PhotoImage()
        piv.translatesAutoresizingMaskIntoConstraints = false
        piv.contentMode = .scaleAspectFill
        piv.clipsToBounds = true
        return piv
    }()
    
    let backButton: UIButton = {
        let bb = UIButton(type: .system)
        bb.setImage(UIImage(named: "back3")?.withRenderingMode(.alwaysOriginal), for: .normal)
        bb.translatesAutoresizingMaskIntoConstraints = false
        bb.contentMode = .scaleAspectFill
        bb.clipsToBounds = true
        return bb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UIApplication.shared.isStatusBarHidden = false
        navigationController?.navigationBar.isHidden = false
    }
    
    func setupComponents() {
        
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        UIApplication.shared.isStatusBarHidden = true
        view.backgroundColor = .white
        view.addSubview(photoImageView)
        view.addSubview(backButton)
        navigationController?.navigationBar.isHidden = true
        
        photoImageView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        photoImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: view.frame.height - 200).isActive = true
        
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
}
