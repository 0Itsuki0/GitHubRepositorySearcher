//
//  RepositoryDetailViewTest.swift
//  GitHubRepositorySearcherUITests
//
//  Created by イツキ on 2023/03/02.
//

import XCTest

final class RepositoryDetailViewTests: XCTestCase {

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
    
    
    func testRepositoryDetailView() {
        
        let searchBar = app.otherElements["SearchBar"]
        searchBar.tap()
        searchBar.typeText("swift")
        
        let sendButton = app.buttons["SendButton"]
        sendButton.tap()
        
        let repositoryListTableView = app.tables["RepositoryListTableView"]
        let repositoryCells = repositoryListTableView.cells
        XCTAssertTrue(repositoryCells.firstMatch.waitForExistence(timeout: 10))

        let repositoryCell = repositoryCells.element(boundBy: 0)
        repositoryCell.tap()
        
        let repositoryDetailAvatarImageView = app.images["RepositoryDetailAvatarImageView"]
        XCTAssertTrue(repositoryDetailAvatarImageView.exists, "The avatar image view exists.")
        
        let repositoryDetailNameLabel = app.staticTexts["RepositoryDetailNameLabel"]
        XCTAssertTrue(repositoryDetailNameLabel.exists, "The repository name label exists.")
        
        let repositoryDetailDescriptionLabel = app.staticTexts["RepositoryDetailDescriptionLabel"]
        XCTAssertTrue(repositoryDetailDescriptionLabel.exists, "The repository description label exists.")
        
        let repositoryDetailLanguageLabel = app.staticTexts["RepositoryDetailLanguageLabel"]
        XCTAssertTrue(repositoryDetailLanguageLabel.exists, "The repository language label exists.")
        
        let repositoryDetailOpenIssuesCountLabel = app.staticTexts["RepositoryDetailOpenIssuesCountLabel"]
        XCTAssertTrue(repositoryDetailOpenIssuesCountLabel.exists, "The open issues count label exists.")
        
        let repositoryDetailWatchersCountLabel = app.staticTexts["RepositoryDetailWatchersCountLabel"]
        XCTAssertTrue(repositoryDetailWatchersCountLabel.exists, "The watchers count label exists.")
        
        let repositoryDetailStarCountLabel = app.staticTexts["RepositoryDetailStarCountLabel"]
        XCTAssertTrue(repositoryDetailStarCountLabel.exists, "The star count label exists.")
        
        let repositoryDetailForksCountLabel = app.staticTexts["RepositoryDetailForksCountLabel"]
        XCTAssertTrue(repositoryDetailForksCountLabel.exists, "The forks count label exists.")
        
    }

    
}
