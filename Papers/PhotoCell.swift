//
//  PhotoCell.swift
//  Papers
//
//  Created by Don Bytyqi on 5/4/17.
//  Copyright © 2017 Don Bytyqi. All rights reserved.
//

import UIKit

class PhotoCell: BaseCollectionViewCell {
    
    var photo: Photo? {
        didSet {
            
            if let userImage = photo?.user.image {
                userImageView.downloadImageFrom(urlString: userImage)
            }
            
            if let userName = photo?.user.name {
                userNameLabel.text = userName
                print(userName)
            }
            
            if let photoLikes = photo?.likes {
                photoLikesLabel.text = photoLikes + " likes"
            }
            
            if let photoImageUrl = photo?.urls?["regular"] {
                photoImageView.downloadImageFrom(urlString: photoImageUrl)
            }
            
        }
    }
    
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
    
    let photoLikesLabel: UILabel = {
        let pll = UILabel()
        pll.translatesAutoresizingMaskIntoConstraints = false
        pll.textColor = .black
        pll.text = "2399 likes"
        pll.font = UIFont.systemFont(ofSize: 14)
        return pll
    }()
    
    let photoImageView: PhotoImageView = {
        let piv = PhotoImageView()
        piv.translatesAutoresizingMaskIntoConstraints = false
        piv.image = UIImage(named: "t")
        piv.contentMode = .scaleAspectFill
        piv.clipsToBounds = true
        return piv
    }()
    
    
    
    override func setupViewsAndComponents() {
        backgroundColor = .white
        
        addSubview(userImageView)
        addSubview(userNameLabel)
        addSubview(photoImageView)
        addSubview(photoLikesLabel)
        
        userImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        userImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        
        photoImageView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        userNameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 20).isActive = true
        userNameLabel.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor).isActive = true
        
        photoLikesLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        photoLikesLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        photoLikesLabel.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor).isActive = true
        photoLikesLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 20).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(roundedRect:photoImageView.bounds,
                                byRoundingCorners:[.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 20, height:  20))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        photoImageView.layer.mask = maskLayer
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 7.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        userNameLabel.numberOfLines = 0
    }
    
    
    
    
}
