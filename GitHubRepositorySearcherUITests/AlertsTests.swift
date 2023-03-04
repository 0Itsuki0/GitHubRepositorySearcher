//
//  AlertsTests.swift
//  GitHubRepositorySearcherUITests
//
//  Created by イツキ on 2023/03/03.
//

import XCTest


final class AlertsTests: XCTestCase {
    
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
    
    
    func testLoader() {
        
        let searchBar = app.otherElements["SearchBar"]
        searchBar.tap()
        searchBar.typeText("swift")
        
        let sendButton = app.buttons["SendButton"]
        sendButton.tap()
        
        let loader = app.alerts.firstMatch
        XCTAssertTrue(loader.exists, "The loader exists.")
        
        let repositoryCells = app.tables["RepositoryListTableView"].cells
        XCTAssertTrue(repositoryCells.firstMatch.waitForExistence(timeout: 10))
        
        XCTAssertFalse(loader.exists, "The loader disappeared.")
        
    }
    
    
    func testErrorAlert() {
        
        let sendButton = app.buttons["SendButton"]
        sendButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists, "The alert exists.")
        XCTAssertTrue(alert.label == "Please enter something!")
        alert.buttons.firstMatch.tap()
        XCTAssertFalse(alert.exists, "The alert disappeared.")

    }
    
}
