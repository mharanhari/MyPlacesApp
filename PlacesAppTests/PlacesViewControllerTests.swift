//
//  PlacesViewControllerTests.swift
//  PlacesAppTests
//
//  Created by Hariharan on 26/09/20.
//  Copyright © 2020 Hariharan. All rights reserved.
//

import XCTest
@testable import PlacesApp

class PlacesViewControllerTests: XCTestCase {

    var placesViewController: PlacesViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        placesViewController = PlacesViewController()
        self.placesViewController.loadView()
        self.placesViewController.viewDidLoad()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHasATableView() {
        XCTAssertNotNil(placesViewController.placesTableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(placesViewController.placesTableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(placesViewController.conforms(to: UITableViewDelegate.self))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(placesViewController.placesTableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(placesViewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(placesViewController.responds(to: #selector(placesViewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(placesViewController.responds(to: #selector(placesViewController.tableView(_:cellForRowAt:))))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
