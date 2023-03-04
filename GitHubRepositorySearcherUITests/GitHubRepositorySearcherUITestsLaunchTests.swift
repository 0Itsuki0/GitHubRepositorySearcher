//
//  GitHubRepositorySearcherUITestsLaunchTests.swift
//  GitHubRepositorySearcherUITests
//
//  Created by Itsuki on 2023/03/02.
//

import XCTest

final class GitHubRepositorySearcherUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
