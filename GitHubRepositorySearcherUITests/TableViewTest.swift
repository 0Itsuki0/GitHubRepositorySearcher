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
        
        let searchBar = app.otherElements["SearchBar"]
        searchBar.tap()
        searchBar.typeText("swift")
        
        let sendButton = app.buttons["SendButton"]
        sendButton.tap()
        
        let repositoryListTableView = app.tables["RepositoryListTableView"]
        XCTAssertTrue(repositoryListTableView.exists, "The repository list tableview exists.")
        let repositoryCells = repositoryListTableView.cells
        XCTAssertTrue(repositoryCells.firstMatch.waitForExistence(timeout: 10))
        

        
        if repositoryCells.count > 0 {
            let count: Int = (repositoryCells.count - 1)
         
            let promise = expectation(description: "Wait for table cells")
         
            for i in stride(from: 0, to: count , by: 1) {
                // Grab the first cell and verify that it exists and tap it
                let repositoryCell = repositoryCells.element(boundBy: i)
                XCTAssertTrue(repositoryCell.exists, "The \(i) cell is in place on the table")
                
                let repositoryCellNameLabel = repositoryCell.staticTexts["RepositoryCellNameLabel"]
                XCTAssertTrue(repositoryCellNameLabel.exists, "The repository cell name label exists.")
                
                let repositoryCellDescriptionLabel = repositoryCell.staticTexts["RepositoryCellDescriptionLabel"]
                XCTAssertTrue(repositoryCellDescriptionLabel.exists, "The repository cell description label exists.")
                
                let repositoryCellLanguageLabel = repositoryCell.staticTexts["RepositoryCellLanguageLabel"]
                XCTAssertTrue(repositoryCellLanguageLabel.exists, "The repository cell language label exists.")
                
                repositoryCell.tap()
         
                if i == (count - 1) {
                    promise.fulfill()
                }
                // Back
                app.navigationBars.buttons.element(boundBy: 0).tap()
            }
            waitForExpectations(timeout: 20, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")
         
        } else {
            XCTAssert(false, "Was not able to find any table cells")
        }
        

    }

}
