//
//  AppleSearch.swift
//  Farfalla
//
//  Created by Stephen Rakonza on 3/15/18.
//  Copyright © 2018 SR. All rights reserved.
//

import UIKit


/*
 movie
 podcast
 music
 musicVideo
 audiobook
 shortFilm
 tvShow
 software
 ebook
 all
 */

class AppleSearch: NSObject {
    
    private var term: String!
    private var media: String!

    init(withSearchTerm searchTerm:String, forMediaType mediaType:String) {
        term = searchTerm
        media = mediaType
    }
    
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }
    
    func executeJob(withCompletion completion:@escaping (SearchResults?, Error?) -> Void) {
        let searchTerm = term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let strUrl = String(format: "https://itunes.apple.com/search?parameterkeyvalue&term=%@&media=%@", searchTerm!, media)
        let url = NSURL(string: strUrl)
        let session = URLSession.shared
        let task = session.dataTask(with: url! as URL, completionHandler: {data, response, error -> Void in
            DispatchQueue.main.async {
                if(error != nil) {
                    // Error in the web request
                    completion( nil, error )
                }
                else {
                    let results = SearchResults.init(fromJson: data!, forTerms: self.term, forMediaType: self.media)
                    completion( results, nil )
                }
            }
        })
        task.resume()
    }
}
