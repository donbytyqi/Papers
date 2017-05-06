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
    static let clientId = "8ee83ac1d45c0ce56dcbb34354714051b55762f9291ee986b8f589e050076943"
    
    func fetchPhotos(url: String?, orderBy: OrderBy, page: Int, query: String? ,completion: @escaping ([Photo]) -> ()) {
        
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
            print("This as well?!")
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        URLSession.shared.dataTask(with: toFetchURL!, completionHandler: {data, response, error in
            
            if error != nil {
                self.showError(error: error as! String)
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
                        let photo = Photo()
                        photo.urls = photoUrl as? [String : String]
                        photo.likes = "\(likes)" + " likes"
                        photo.user.name = userName
                        photo.user.image = userImageUrl
                        print(userName)
                        photos.append(photo)
                    }
                }
                else {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [[String : AnyObject]]
                    
                    for i in 0..<jsonData.count {
                        guard let photoDict = jsonData[i] as [String : AnyObject]? else { return }
                        guard let userDict = photoDict["user"] as! [String : AnyObject]? else { return }
                        guard let profileImages = userDict["profile_image"] as! [String : AnyObject]? else { return }
                        guard let photoUrl = photoDict["urls"] as? [String : AnyObject] else { return }
                        let userName = userDict["name"] as! String
                        let userImageUrl = profileImages["medium"] as! String
                        let likes = photoDict["likes"] as! Int
                        let photo = Photo()
                        photo.urls = photoUrl as? [String : String]
                        photo.likes = "\(likes)" + " likes"
                        photo.user.name = userName
                        photo.user.image = userImageUrl
                        print(userName)
                        photos.append(photo)
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
