//
//  SearchBarTest.swift
//  GitHubRepositorySearcherUITests
//
//  Created by イツキ on 2023/03/02.
//

import XCTest

final class SearchBarTests: XCTestCase {

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
    
    
    func testSearchBarInteraction() {
        
        let searchBar = app.otherElements["SearchBar"]
        XCTAssertTrue(searchBar.exists, "The searchBar exists.")
        searchBar.tap()
        searchBar.typeText("swift")
        
    }
    
    
    func testSendButtonInteraction() {
        
        let sendButton = app.buttons["SendButton"]
        XCTAssertTrue(sendButton.exists, "The send button exists.")
        sendButton.tap()
        
    }
    
   
}
