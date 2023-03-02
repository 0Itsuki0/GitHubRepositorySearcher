//
//  ResponseTest.swift
//  GitHubRepositorySearcherTests
//
//  Created by イツキ on 2023/03/02.
//

import XCTest
@testable import GitHubRepositorySearcher


final class ResponseTests: XCTestCase {

    func testResponseCreation() {
        let data = dataFrom(filename: "sampleResponse")
        let decoder = JSONDecoder()
        let response = try! decoder.decode(Response.self, from: data)
        XCTAssertEqual(response.totalCount, 265387)
        XCTAssertEqual(response.incompleteResults, false)
        XCTAssertNotNil(response.items)
        
    }

}
