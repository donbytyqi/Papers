//
//  Extensions.swift
//  Papers
//
//  Created by Don Bytyqi on 5/5/17.
//  Copyright © 2017 Don Bytyqi. All rights reserved.
//

import UIKit


enum OrderBy: String {
    case popular = "popular"
    case latest = "latest"
    case oldest = "oldest"
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class PhotoImage: UIImageView {
    
    var photoImageURL: String?
    
    func downloadImageFrom(urlString: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        photoImageURL = urlString
        
        guard let url = URL(string: urlString) else { return }
        
        if let isCachedImage = imageCache.object(forKey: urlString as AnyObject) {
            self.image = isCachedImage as? UIImage
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error!)
            }
            
            DispatchQueue.main.async {
                guard let cachedImage = UIImage(data: data!) else { return }
                
                if self.photoImageURL == urlString {
                    self.image = cachedImage
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
                imageCache.setObject(cachedImage, forKey: urlString as AnyObject)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            }.resume()
        
    }
}

extension UISearchBar {
    func cancelButton(_ isEnabled: Bool) {
        for subview in self.subviews {
            for button in subview.subviews {
                if button.isKind(of: UIButton.self) {
                    let cancelButton = button as! UIButton
                    cancelButton.isEnabled = isEnabled
                }
            }
        }
    }
}
