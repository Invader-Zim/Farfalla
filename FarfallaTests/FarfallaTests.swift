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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAppleSearch00() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
