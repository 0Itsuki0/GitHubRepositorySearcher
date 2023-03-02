//
//  RepositoryTest.swift
//  GitHubRepositorySearcherTests
//
//  Created by イツキ on 2023/03/02.
//

import XCTest
@testable import GitHubRepositorySearcher


final class RepositoryTests: XCTestCase {


    func testRepositoryCreation() {
        let data = dataFrom(filename: "sampleRepository")
        let decoder = JSONDecoder()
        let repository = try! decoder.decode(Repository.self, from: data)
        XCTAssertEqual(repository.id, 44838949)
        XCTAssertEqual(repository.fullName, "apple/swift")
        XCTAssertEqual(repository.owner.id, 10639145)
        XCTAssertEqual(repository.owner.avatarURL, "https://avatars.githubusercontent.com/u/10639145?v=4")
        XCTAssertEqual(repository.owner.url, "https://api.github.com/users/apple")
        XCTAssertEqual(repository.description, "The Swift Programming Language")
        XCTAssertEqual(repository.createdDateTimeString, "2015-10-23T21:15:07Z")
        XCTAssertEqual(repository.updatedDateTimeString, "2023-03-02T00:54:28Z")
        XCTAssertEqual(repository.stargazersCount, 61951)
        XCTAssertEqual(repository.language, "C++")
        XCTAssertEqual(repository.forks, 9976)
        XCTAssertEqual(repository.openIssues, 6407)
        XCTAssertEqual(repository.watchersCount, 61951)
        XCTAssertNotNil(repository.avatarImageUrl)
        XCTAssertEqual(repository.createdDate, "2015/10/23")
        XCTAssertEqual(repository.updatedDate, "2023/03/02")
        
    }
    
    func testRepositoryNilAvatarURL() {
        let data = dataFrom(filename: "sampleRepositoryNilAvatarURL")
        let decoder = JSONDecoder()
        let repository = try! decoder.decode(Repository.self, from: data)
        XCTAssertEqual(repository.owner.avatarURL, nil)
        XCTAssertEqual(repository.avatarImageUrl, nil)
    }
    
    func testRepositoryNilDateTimeString() {
        let data = dataFrom(filename: "sampleRepositoryNilDateTime")
        let decoder = JSONDecoder()
        let repository = try! decoder.decode(Repository.self, from: data)
        XCTAssertEqual(repository.createdDate, nil)
        XCTAssertEqual(repository.updatedDate, nil)
    }

    
    
    
}


