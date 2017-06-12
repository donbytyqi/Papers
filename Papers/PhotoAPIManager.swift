//
//  PhotoAPIManager.swift
//  Papers
//
//  Created by Don Bytyqi on 5/5/17.
//  Copyright © 2017 Don Bytyqi. All rights reserved.
//

import UIKit

class PhotoAPIManager: NSObject {
    
    static let shared = PhotoAPIManager()
    static let clientId = "your unsplash key here"
    var moreUserInfo = String()
    var photo = Photo()
    
    func fetchPhotos(url: String?, orderBy: OrderBy, page: Int, query: String? , quality: String, completion: @escaping ([Photo]) -> ()) {
        
        var toFetchURL: URL?
        var photos = [Photo]()
        
        if url == "" && query == "" {
            toFetchURL = URL(string: "https://api.unsplash.com/photos?order_by=\(orderBy.rawValue)&page=\(page)&client_id=\(PhotoAPIManager.clientId)")
            print(toFetchURL!)
        }
        else if query != "" && url != "" {
            toFetchURL = URL(string: "https://api.unsplash.com/search/photos?query=\(query!)&page=\(page)&client_id=\(PhotoAPIManager.clientId)")
        }
        else {
            toFetchURL = URL(string: url!)
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        URLSession.shared.dataTask(with: toFetchURL!, completionHandler: {data, response, error in
            
            if error != nil {
                self.showError(error: (error?.localizedDescription)!)
                print((error?.localizedDescription)!)
            }
            
            do {
                if query != "" && url != "" {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    
                    guard let results = jsonData["results"] as? NSArray else { return }
                    for i in 0..<results.count {
                        guard let photoDict = results[i] as? [String : AnyObject] else { return }
                        guard let userDict = photoDict["user"] as! [String : AnyObject]? else { return }
                        guard let profileImages = userDict["profile_image"] as! [String : AnyObject]? else { return }
                        guard let photoUrl = photoDict["urls"] as? [String : AnyObject] else { return }
                        let userName = userDict["name"] as! String
                        
                        let userImageUrl = profileImages["medium"] as! String
                        let likes = photoDict["likes"] as! Int
                        self.photo = Photo()
                        self.photo.urls = photoUrl as? [String : String]
                        self.photo.likes = "\(likes)" + " likes"
                        self.photo.user.name = userName
                        self.photo.user.image = userImageUrl
                        self.moreUserInfo = photoDict["links"]?["self"] as! String
                        photos.append(self.photo)
                    }
                }
                else {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [[String : AnyObject]]
                    
                    for i in 0..<jsonData.count {
                        let p = Photo()
                        guard let photoDict = jsonData[i] as [String : AnyObject]? else { return }
                        guard let userDict = photoDict["user"] as! [String : AnyObject]? else { return }
                        guard let profileImages = userDict["profile_image"] as! [String : AnyObject]? else { return }
                        guard let photoUrl = photoDict["urls"] as? [String : AnyObject] else { return }
                        guard let currentCo = photoDict["current_user_collections"] as? NSArray else { return }
                        
                        for j in 0..<currentCo.count {
                            let dict = currentCo[j] as? [String : AnyObject]
                            p.title = dict?["title"] as? String
                        }
                        
                        let userName = userDict["name"] as! String
                        let userImageUrl = profileImages["medium"] as! String
                        let likes = photoDict["likes"] as! Int
                        p.urls = photoUrl as? [String : String]
                        p.likes = "\(likes)"
                        p.user.name = userName
                        p.user.image = userImageUrl
                        photos.append(p)
                    }
                }
                
                DispatchQueue.main.async {
                    completion(photos)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
            }
            catch {
                self.showError(error: error as! String)
            }
            
        }).resume()
    }
    
    
    func showError(error: String) {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.rootViewController?.showAlert(title: "Something happened", message: error)
        return
    }
    
}
