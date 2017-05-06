//
//  Photo.swift
//  Papers
//
//  Created by Don Bytyqi on 5/4/17.
//  Copyright © 2017 Don Bytyqi. All rights reserved.
//

import UIKit

class Photo: NSObject {
    
    var id: String?
    var likes: String?
    var imageURL: String?
    var urls: [String : String]?
    
    var user: User = User()
}
