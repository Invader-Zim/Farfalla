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
    
    //We need a concept of image download in progress, otherwise we might kick off multiple requests
    private let set: NSMutableSet?

    //Prevents the default '()' initializer outside 'sharedInstance'
    private init() {
        cache = NSCache<NSString, NSObject>()
        set = NSMutableSet.init()
    }
    
    func imageFromUrl(url: URL) -> Any? {
        //Check cache first
        let imageCached = cache?.object(forKey: url.absoluteString as NSString)
        if ( imageCached != nil ) {
            return imageCached
        }

        // We are already in the process of downloading the image.
        if ( set?.contains(url) )! {
            return nil
        }
        set?.add(url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async() {
                self.set?.remove(url)
                self.cache?.setObject(image!, forKey: url.absoluteString as NSString)
                NotificationCenter.default.post(name: .imageCacheChanged, object: nil, userInfo: ["urlString" : url.absoluteString as NSString])
            }
            }.resume()
        return nil
    }
    
}
