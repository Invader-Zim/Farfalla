//
//  ImageCache.swift
//  Farfalla
//
//  Created by Stephen Rakonza on 3/16/18.
//  Copyright © 2018 SR. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let imageCacheChanged = Notification.Name("imageCacheChanged")
}

class ImageCache {
    static let sharedInstance = ImageCache()
    private let cache: NSCache<NSString, NSObject>?

    //Prevents the default '()' initializer outside 'sharedInstance'
    private init() {
        cache = NSCache<NSString, NSObject>()
    }
    
    func imageFromUrl(url: URL) -> Any? {
        //Check cache first
        let imageCached = cache?.object(forKey: url.absoluteString as NSString)
        if ( imageCached != nil ) {
            return imageCached
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async() {
                self.cache?.setObject(image!, forKey: url.absoluteString as NSString)
                NotificationCenter.default.post(name: .imageCacheChanged, object: nil, userInfo: ["urlString" : url.absoluteString as NSString])
            }
            }.resume()
        return nil
    }
    
}
