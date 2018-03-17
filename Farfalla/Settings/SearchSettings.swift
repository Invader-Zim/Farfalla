//
//  Settings.swift
//  Farfalla
//
//  Created by Stephen Rakonza on 3/17/18.
//  Copyright © 2018 SR. All rights reserved.
//

import Foundation

class SearchSettings {
    static let sharedInstance = SearchSettings()
    
    //Prevents the default '()' initializer outside 'sharedInstance'
    private init() {
    }
    
    var searchText: String? {
        get {
            let str = UserDefaults.standard.string(forKey: "searchText")
            if ( str == nil ) {
                return ""
            }
            return str
        }
        set(newstr) {
            UserDefaults.standard.set(newstr, forKey: "searchText")
        }
    }

    var mediaType: String? {
        get {
            let str = UserDefaults.standard.string(forKey: "mediaType")
            if ( str == nil ) {
                return "all"
            }
            return str
        }
        set(newstr) {
            UserDefaults.standard.set(newstr, forKey: "mediaType")
        }
    }
    

    
}
