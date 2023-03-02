//
//  XCTestCase+loadData.swift
//  GitHubRepositorySearcherTests
//
//  Created by イツキ on 2023/03/02.
//

import XCTest


extension XCTestCase {
   func dataFrom(filename: String) -> Data {
        let path = Bundle(for: GitHubRepositorySearcherTests.self).path(forResource: filename, ofType: "json")!
        return NSData(contentsOfFile: path)! as Data
    }
}
