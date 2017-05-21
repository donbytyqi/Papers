//
//  PhotoInfoController.swift
//  Papers
//
//  Created by Don Bytyqi on 5/6/17.
//  Copyright © 2017 Don Bytyqi. All rights reserved.
//

import UIKit

class PhotoInfoController: UIViewController {
    
    var url: String?
    
    var user = User()
    
    var photo: Photo? {
        didSet {
            // "regular" or "raw" for better quality
            if let photoImageUrl = photo?.urls?["regular"] {
                photoImageView.downloadImageFrom(urlString: photoImageUrl)
            }
            
            if let userImageUrl = photo?.user.image {
                userImageView.downloadImageFrom(urlString: userImageUrl)
            }
            
            if let userName = photo?.user.name {
                userNameLabel.text = userName
            }
            
            if let likes = photo?.likes {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.string(from: NSNumber(value: Int(likes)!))
                likesLabel.text = likes
            }
            
            if let title = photo?.title {
                downloadsLabel.text = title
            }
        }
    }
    
    let photoImageView: PhotoImageView = {
        let piv = PhotoImageView()
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
    
    let userImageView: PhotoImageView = {
        let uiv = PhotoImageView()
        uiv.translatesAutoresizingMaskIntoConstraints = false
        uiv.contentMode = .scaleAspectFill
        uiv.clipsToBounds = true
        return uiv
    }()
    
    let userNameLabel: UILabel = {
        let unl = UILabel()
        unl.translatesAutoresizingMaskIntoConstraints = false
        unl.textColor = .black
        unl.text = "Hello User World"
        return unl
    }()
    
    let likesLabel: UILabel = {
        let ll = UILabel()
        ll.translatesAutoresizingMaskIntoConstraints = false
        ll.textColor = .black
        ll.text = "Likes\n 99"
        ll.font = UIFont.systemFont(ofSize: 14)
        return ll
    }()
    
    let viewsLabel: UILabel = {
        let vl = UILabel()
        vl.translatesAutoresizingMaskIntoConstraints = false
        vl.textColor = .black
        vl.text = "99"
        vl.font = UIFont.systemFont(ofSize: 14)
        return vl
    }()
    
    let downloadsLabel: UILabel = {
        let dl = UILabel()
        dl.translatesAutoresizingMaskIntoConstraints = false
        dl.textColor = .black
        dl.text = "12452\n 90"
        dl.font = UIFont.systemFont(ofSize: 14)
        return dl
    }()
    
    let three: UILabel = {
        let t = UILabel()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.textColor = .lightGray
        t.text = "Likes        Views        Downloads"
        return t
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
        view.addSubview(userImageView)
        view.addSubview(userNameLabel)
        view.addSubview(likesLabel)
        view.addSubview(three)
        view.addSubview(viewsLabel)
        view.addSubview(downloadsLabel)
        navigationController?.navigationBar.isHidden = true
        
        photoImageView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        photoImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: view.frame.height - 150).isActive = true
        
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        
        userImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        userImageView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 20).isActive = true
        
        
        userNameLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 10).isActive = true
        userNameLabel.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor).isActive = true
        
        
        three.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        three.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        three.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        likesLabel.leftAnchor.constraint(equalTo: three.leftAnchor, constant: 67).isActive = true
        likesLabel.topAnchor.constraint(equalTo: three.bottomAnchor, constant: 5).isActive = true
        
        viewsLabel.centerXAnchor.constraint(equalTo: three.centerXAnchor, constant: -10).isActive = true
        viewsLabel.topAnchor.constraint(equalTo: three.bottomAnchor, constant: 5).isActive = true
        
        downloadsLabel.rightAnchor.constraint(equalTo: three.rightAnchor, constant: -67).isActive = true
        downloadsLabel.topAnchor.constraint(equalTo: three.bottomAnchor, constant: 5).isActive = true
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        userImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePortofolio)))
        userImageView.isUserInteractionEnabled = true
        
        likesLabel.numberOfLines = 0
        viewsLabel.numberOfLines = 0
        likesLabel.textAlignment = .right
        three.textAlignment = .center
        
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func handlePortofolio() {
    }
    
}
