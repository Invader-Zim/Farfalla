//
//  AppleSearchMediaTypes.swift
//  Farfalla
//
//  Created by Stephen Rakonza on 3/15/18.
//  Copyright © 2018 SR. All rights reserved.
//

import UIKit

class AppleSearchMediaTypes {
    static let sharedInstance = AppleSearchMediaTypes()
    
    var mediaTypes: Dictionary<String, String>!
    var mediaTypesSorted: Array<String>!

    //Prevents the default '()' initializer outside 'sharedInstance'
    private init() {
        mediaTypes = Dictionary()
        mediaTypes["movie"] = "Movie"
        mediaTypes["podcast"] = "Podcast"
        mediaTypes["music"] = "Music"
        mediaTypes["musicVideo"] = "Music Video"
        mediaTypes["audiobook"] = "Audiobook"
        mediaTypes["shortFilm"] = "Short Film"
        mediaTypes["tvShow"] = "TV Show"
        mediaTypes["software"] = "Software"
        mediaTypes["ebook"] = "eBook"
        mediaTypes["all"] = "All"
        
        //iTunes lists the first 5 (after 'all') in the following order
        //I added the rest, ordered by intuition of customer desire
        mediaTypesSorted = Array()
        mediaTypesSorted.append("all")
        mediaTypesSorted.append("music")
        mediaTypesSorted.append("movie")
        mediaTypesSorted.append("tvShow")
        mediaTypesSorted.append("audiobook")
        mediaTypesSorted.append("podcast")
        mediaTypesSorted.append("ebook")
        mediaTypesSorted.append("musicVideo")
        mediaTypesSorted.append("shortFilm")
        mediaTypesSorted.append("software")
    }
}
