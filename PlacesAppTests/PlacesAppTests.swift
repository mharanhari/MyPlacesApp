//
//  PlacesAppTests.swift
//  PlacesAppTests
//
//  Created by Hariharan on 26/09/20.
//  Copyright © 2020 Hariharan. All rights reserved.
//

import XCTest
@testable import PlacesApp

class PlacesAppTests: XCTestCase {

    var placeFetcher:PlaceFetcher!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        placeFetcher = PlaceFetcher()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        placeFetcher = nil
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testParsingResponseJSONTitle() {
        let data = StubPlaceResponseResult.jsonResponseStr.data(using: .utf8)
        
        if let response = placeFetcher.decodeJSONResponseData(responseData: data!, type: PlaceResponse.self){
            XCTAssertEqual(response.title,"About Canada","Json pasrsing should be done and title is About Canada")
        }
    }
    
    func testParsingResponseJSONRows() {
        let data = StubPlaceResponseResult.jsonResponseStr.data(using: .utf8)
        
        if let response = placeFetcher.decodeJSONResponseData(responseData: data!, type: PlaceResponse.self){
            XCTAssertEqual(response.rows.count,2,"Json pasrsing should be done and rows count should be 2")
        }
    }
    
    func testParsingResponseJSONRowsElementValue() {
        let data = StubPlaceResponseResult.jsonResponseStr.data(using: .utf8)
        
        if let response = placeFetcher.decodeJSONResponseData(responseData: data!, type: PlaceResponse.self){
            XCTAssertNotNil(response.rows.first, "Rows info could be decoded")

            XCTAssertTrue(response.rows.first?.title == "Beavers")
            XCTAssertTrue(response.rows.first?.imageHref == "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
        }
    }
    
    func testParsingResponseJSONRowsElementValueNil() {
        let data = StubPlaceResponseResult.jsonResponseStr.data(using: .utf8)
        
        if let response = placeFetcher.decodeJSONResponseData(responseData: data!, type: PlaceResponse.self){
            XCTAssertNil(response.rows.last?.description)
        }
    }
    
    func testParsingResponseJSONRowsElementImageUrl() {
        let data = StubPlaceResponseResult.jsonResponseStr.data(using: .utf8)
        
        if let response = placeFetcher.decodeJSONResponseData(responseData: data!, type: PlaceResponse.self){
            XCTAssertNil(response.rows.first?.imageHref)
            XCTAssertEqual(response.rows.first?.imageHref?.prefix(4),"http","Image should be a download url")
        }
    }


}

struct StubPlaceResponseResult {
    static let jsonResponseStr = """
        "title": "About Canada",
        "rows": [{
                "title": "Beavers",
                "description": "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
                "imageHref": "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
            },
            {
                "title": "Flag",
                "description": null,
                "imageHref": "http://images.findicons.com/files/icons/662/world_flag/128/flag_of_canada.png"
            }
            ]
    """
}

