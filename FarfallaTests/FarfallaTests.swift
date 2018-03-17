//
//  FarfallaTests.swift
//  FarfallaTests
//
//  Created by Stephen Rakonza on 3/15/18.
//  Copyright © 2018 SR. All rights reserved.
//

import XCTest
@testable import Farfalla

class FarfallaTests: XCTestCase {
    
    private var imageCacheExpectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAppleSearch00() {
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Apple Search")

        let mediaType = AppleSearchMediaTypes.init().mediaTypesSorted[0];
        let search = AppleSearch.init(withSearchTerm: "beatles", forMediaType: mediaType)
        search.executeJob(withCompletion: { (results: SearchResults?, error: Error?) in
            XCTAssert( error == nil )
            XCTAssert( results != nil )
            
            XCTAssert( results?.resultItems?.count == 50 )
            XCTAssert( results?.resultItems![0].wrapperType?.count != 0)
            expectation.fulfill()
        })
        
        //Wait for async task to complete
        wait(for: [expectation], timeout: 10.0)
    }
    /*
     {
     "resultCount":50,
     "results": [
     {"wrapperType":"track", "kind":"song", "artistId":314333781, "collectionId":664620720, "trackId":664620811, "artistName":"Twinkle Twinkle Little Rock Star", "collectionName":"Lullaby Versions of Tool", "trackName":"Sober", "collectionCensoredName":"Lullaby Versions of Tool", "trackCensoredName":"Sober", "artistViewUrl":"https://itunes.apple.com/us/artist/twinkle-twinkle-little-rock-star/314333781?uo=4", "collectionViewUrl":"https://itunes.apple.com/us/album/sober/664620720?i=664620811&uo=4", "trackViewUrl":"https://itunes.apple.com/us/album/sober/664620720?i=664620811&uo=4",
     "previewUrl":"https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/Music6/v4/9c/06/ea/9c06ea7f-7fda-ce0b-fa91-e438a8949625/mzaf_8213740159282280590.plus.aac.p.m4a", "artworkUrl30":"http://is5.mzstatic.com/image/thumb/Music4/v4/81/28/63/81286307-1b53-92cd-d960-1e2d0c32ecf3/source/30x30bb.jpg", "artworkUrl60":"http://is5.mzstatic.com/image/thumb/Music4/v4/81/28/63/81286307-1b53-92cd-d960-1e2d0c32ecf3/source/60x60bb.jpg", "artworkUrl100":"http://is5.mzstatic.com/image/thumb/Music4/v4/81/28/63/81286307-1b53-92cd-d960-1e2d0c32ecf3/source/100x100bb.jpg", "collectionPrice":9.99, "trackPrice":0.99, "releaseDate":"2013-07-16T07:00:00Z", "collectionExplicitness":"notExplicit", "trackExplicitness":"notExplicit", "discCount":1, "discNumber":1, "trackCount":12, "trackNumber":1, "trackTimeMillis":221000, "country":"USA", "currency":"USD", "primaryGenreName":"Children's Music", "isStreamable":true},
     {"wrapperType":"track", "kind":"song", "artistId":140870416, "collectionId":407673919, "trackId":407673921, "artistName":"Tool", "collectionName":"Escape from L.A. (Music from and Inspired By the Film)", "trackName":"Sweat", "collectionCensoredName":"Escape from L.A. (Music from and Inspired By the Film)", "trackCensoredName":"Sweat", "collectionArtistId":36270, "collectionArtistName":"Various Artists", "artistViewUrl":"https://itunes.apple.com/us/artist/tool/140870416?uo=4", "collectionViewUrl":"https://itunes.apple.com/us/album/sweat/407673919?i=407673921&uo=4", "trackViewUrl":"https://itunes.apple.com/us/album/sweat/407673919?i=407673921&uo=4", "previewUrl":"https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/Music/4f/0f/4b/mzm.rbtgyloz.aac.p.m4a", "artworkUrl30":"http://is3.mzstatic.com/image/thumb/Music/v4/37/18/83/37188312-d22a-6c1f-3844-c2b08f741488/source/30x30bb.jpg", "artworkUrl60":"http://is3.mzstatic.com/image/thumb/Music/v4/37/18/83/37188312-d22a-6c1f-3844-c2b08f741488/source/60x60bb.jpg", "artworkUrl100":"http://is3.mzstatic.com/image/thumb/Music/v4/37/18/83/37188312-d22a-6c1f-3844-c2b08f741488/source/100x100bb.jpg", "collectionPrice":9.99, "trackPrice":-1.00, "releaseDate":"2010-12-13T08:00:00Z", "collectionExplicitness":"notExplicit", "trackExplicitness":"notExplicit", "discCount":1, "discNumber":1, "trackCount":14, "trackNumber":2, "trackTimeMillis":216200, "country":"USA", "currency":"USD", "primaryGenreName":"Soundtrack", "isStreamable":false}
     ]}
 */
    func imageCacheChanged(notification: NSNotification){
        let strUrl = notification.userInfo!["urlString"] as! String
        let url = URL.init(string: strUrl )
        let img = ImageCache.sharedInstance.imageFromUrl(url: url!)
        XCTAssert( img != nil )

        self.imageCacheExpectation?.fulfill()
    }
    
    func imageFromUrl(withURL url:URL) {
        self.imageCacheExpectation = XCTestExpectation(description: "ImageCache")
        
        let img = ImageCache.sharedInstance.imageFromUrl(url: url)
        XCTAssert( img == nil )//The image should not yet be in the cache
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.imageCacheChanged), name: .imageCacheChanged, object: nil)
        
        //Wait for async task to complete
        wait(for: [self.imageCacheExpectation!], timeout: 30.0)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func imageFromCache(withURL url:URL) {
        let img = ImageCache.sharedInstance.imageFromUrl(url: url)
        XCTAssert( img != nil )//The image should not yet be in the cache
    }

    func testImageCache00() {
        imageFromUrl(withURL: URL.init(string: "https://i.pinimg.com/736x/21/44/e9/2144e96dcf6c729df0822fffee6cd1c9--cd-cover-design-cd-design.jpg")!)
    }
    
    func testImageCache01() {
        imageFromUrl(withURL: URL.init(string: "http://is5.mzstatic.com/image/thumb/Music4/v4/81/28/63/81286307-1b53-92cd-d960-1e2d0c32ecf3/source/30x30bb.jpg")!)
    }
    
    func testImageCache02() {
        imageFromUrl(withURL: URL.init(string: "http://is5.mzstatic.com/image/thumb/Music4/v4/81/28/63/81286307-1b53-92cd-d960-1e2d0c32ecf3/source/60x60bb.jpg")!)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
