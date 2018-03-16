//
//  ResultItem.swift
//  Farfalla
//
//  Created by Stephen Rakonza on 3/15/18.
//  Copyright © 2018 SR. All rights reserved.
//

/*
 {
 "resultCount":50,
 "results": [
 {"wrapperType":"track",
 "kind":"song",
 "artistId":909253,
 "collectionId":120954021,
 "trackId":120954025,
 "artistName":"Jack Johnson",
 "collectionName":"Sing-a-Longs and Lullabies for the Film Curious George",
 "trackName":"Upside Down",
 "collectionCensoredName":"Sing-a-Longs and Lullabies for the Film Curious George",
 "trackCensoredName":"Upside Down",
 "artistViewUrl":"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewArtist?id=909253",
 "collectionViewUrl":"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewAlbum?i=120954025&id=120954021&s=143441",
 "trackViewUrl":"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewAlbum?i=120954025&id=120954021&s=143441",
 "previewUrl":"http://a1099.itunes.apple.com/r10/Music/f9/54/43/mzi.gqvqlvcq.aac.p.m4p",
 "artworkUrl60":"http://a1.itunes.apple.com/r10/Music/3b/6a/33/mzi.qzdqwsel.60x60-50.jpg",
 "artworkUrl100":"http://a1.itunes.apple.com/r10/Music/3b/6a/33/mzi.qzdqwsel.100x100-75.jpg",
 "collectionPrice":10.99,
 "trackPrice":0.99,
 "collectionExplicitness":"notExplicit",
 "trackExplicitness":"notExplicit",
 "discCount":1,
 "discNumber":1,
 "trackCount":14,
 "trackNumber":1,
 "trackTimeMillis":210743,
 "country":"USA",
 "currency":"USD",
 "primaryGenreName":"Rock"}
 ]
 }
 */

import UIKit

class ResultItem: NSObject {

    private var resultDict: Dictionary<String, Any>?
    
    init(fromDict dict: Dictionary<String, Any>) {
        resultDict = dict
    }
    
    var wrapperType: String? {
        get {
            return resultDict?["wrapperType"] as? String;
        }
    }
    
    var kind: String? {
        get {
            return resultDict?["kind"] as? String;
        }
    }
    
    var artistId: String? {
        get {
            return resultDict?["artistId"] as? String;
        }
    }
    
    var collectionId: String? {
        get {
            return resultDict?["collectionId"] as? String;
        }
    }
    
    var trackId: Int? {
        get {
            let num = resultDict?["trackId"] as? NSNumber;
            return num?.intValue
        }
    }
    
    var artistName: String? {
        get {
            return resultDict?["artistName"] as? String;
        }
    }
    
    var collectionName: String? {
        get {
            return resultDict?["collectionName"] as? String;
        }
    }
    
    var trackName: String? {
        get {
            return resultDict?["trackName"] as? String;
        }
    }
    
    var collectionCensoredName: String? {
        get {
            return resultDict?["collectionCensoredName"] as? String;
        }
    }
    
    var trackCensoredName: String? {
        get {
            return resultDict?["trackCensoredName"] as? String;
        }
    }
    
    var artistViewUrl: String? {
        get {
            return resultDict?["artistViewUrl"] as? String;
        }
    }
    
    var collectionViewUrl: String? {
        get {
            return resultDict?["collectionViewUrl"] as? String;
        }
    }
    
    var trackViewUrl: String? {
        get {
            return resultDict?["trackViewUrl"] as? String;
        }
    }
    
    var previewUrl: String? {
        get {
            return resultDict?["previewUrl"] as? String;
        }
    }
    
    var artworkUrl60: String? {
        get {
            return resultDict?["artworkUrl60"] as? String;
        }
    }
    
    var artworkUrl100: String? {
        get {
            return resultDict?["artworkUrl100"] as? String;
        }
    }
    
    var collectionPrice: Float? {
        get {
            let num = resultDict?["collectionPrice"] as? NSNumber;
            return num?.floatValue
        }
    }
    
    var trackPrice: Float? {
        get {
            let num = resultDict?["trackPrice"] as? NSNumber;
            return num?.floatValue
        }
    }
    
    var collectionExplicitness: String? {
        get {
            return resultDict?["collectionExplicitness"] as? String;
        }
    }
    
    var trackExplicitness: String? {
        get {
            return resultDict?["trackExplicitness"] as? String;
        }
    }
    
    var discCount: Int? {
        get {
            let num = resultDict?["discCount"] as? NSNumber;
            return num?.intValue
        }
    }
    
    var discNumber: Int? {
        get {
            let num = resultDict?["discNumber"] as? NSNumber;
            return num?.intValue
        }
    }
    
    var trackCount: Int? {
        get {
            let num = resultDict?["trackCount"] as? NSNumber;
            return num?.intValue
        }
    }
    
    var trackNumber: Int? {
        get {
            let num = resultDict?["trackNumber"] as? NSNumber;
            return num?.intValue
        }
    }
    
    var trackTimeMillis: Int? {
        get {
            let num = resultDict?["trackTimeMillis"] as? NSNumber;
            return num?.intValue
        }
    }
    
    var country: String? {
        get {
            return resultDict?["country"] as? String;
        }
    }
    
    var currency: String? {
        get {
            return resultDict?["currency"] as? String;
        }
    }
    
    var primaryGenreName: String? {
        get {
            return resultDict?["primaryGenreName"] as? String;
        }
    }
    
}
