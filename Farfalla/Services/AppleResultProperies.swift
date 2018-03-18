//
//  AppleResultProperies.swift
//  Farfalla
//
//  Created by Stephen Rakonza on 3/17/18.
//  Copyright © 2018 SR. All rights reserved.
//

import UIKit

class AppleResultProperies {
    static let sharedInstance = AppleResultProperies()
    
    var resultProperties: Dictionary<String, String>!
    var propertiesSorted: Array<String>!
    
    //Prevents the default '()' initializer outside 'sharedInstance'
    private init() {
        resultProperties = Dictionary()
        resultProperties["collectionName"] = "Collection"
        resultProperties["artistName"] = "Artist"
        resultProperties["trackName"] = "Track"
        resultProperties["collectionPrice"] = "Collection Price"
        resultProperties["trackPrice"] = "Track Price"
        resultProperties["primaryGenreName"] = "Genre"
        
        //iTunes lists the first 5 (after 'all') in the following order
        //I added the rest, ordered by intuition of customer desire
        propertiesSorted = Array()
        propertiesSorted.append("collectionName")
        propertiesSorted.append("artistName")
        propertiesSorted.append("trackName")
        propertiesSorted.append("collectionPrice")
        propertiesSorted.append("trackPrice")
        propertiesSorted.append("primaryGenreName")
    }
}

