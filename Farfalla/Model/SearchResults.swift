//
//  SearchResults.swift
//  Farfalla
//
//  Created by Stephen Rakonza on 3/15/18.
//  Copyright © 2018 SR. All rights reserved.
//

import UIKit

class SearchResults: NSObject {
    
    var resultItems: Array<ResultItem>?
    var searchTerms: String?
    var mediaType: String?

    /*
     {
        "resultCount":50,
        "results": [...]
     }
     */
    init(fromJson jsonData: Data, forTerms terms: String, forMediaType media:String) {
        do {
            searchTerms = terms
            mediaType = media
            
            let resultDict = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
            
            let results = resultDict!["results"] as! Array< Dictionary<String, Any> >
            resultItems = Array.init()

            //Prefetch the results into ResultItem objects
            for result in results {
                let item = ResultItem.init(fromDict: result)
                resultItems?.append(item)
            }
        } catch {
            
        }
     }
}
