//
//  TableViewTest.swift
//  GitHubRepositorySearcherUITests
//
//  Created by イツキ on 2023/03/02.
//

import XCTest

final class TableViewTest: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
    }
    
    override func tearDownWithError() throws {
        app.terminate()
        app = nil
        try super.tearDownWithError()
    }
    
    
    
    func testTableViewInteraction() {
        let repositoryListTableView = app.tables["RepositoryListTableView"]
        XCTAssertTrue(repositoryListTableView.exists, "The repository list tableview exists")
        let repositoryCells = repositoryListTableView.cells
        

    }
    

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
