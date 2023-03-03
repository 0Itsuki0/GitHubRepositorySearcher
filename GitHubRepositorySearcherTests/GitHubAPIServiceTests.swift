//
//  GitHubAPIServiceTests.swift
//  GitHubRepositorySearcherTests
//
//  Created by イツキ on 2023/03/02.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift
@testable import GitHubRepositorySearcher


final class GitHubAPIServiceTests: XCTestCase {
    
    func testFetchRepositoriesSuccess() async {
      let expectation = XCTestExpectation(description: "Fetching data from server")
        stub(condition: isHost("api.github.com") && isPath("/search/repositories") ) { _ in
            return HTTPStubsResponse(
                fileAtPath: OHPathForFile("sampleResponse.json", type(of: self))!,
                statusCode: 200,
                headers: nil
            )
      }
        do {
            let repositoryList = try await GitHubAPIService.fetchRepository(for: "swift")
            XCTAssert((repositoryList as Any) is [Repository])
            XCTAssertEqual(repositoryList.count, 30)
            XCTAssertEqual(repositoryList.first?.id, 44838949)
        } catch (let error){
            XCTAssertNil(error)
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
    
    
    
    func testFetchRepositoriesBadRequest() async {
        let expectation = XCTestExpectation(description: "Fetching data from server")
          stub(condition: isHost("api.github.com") && isPath("/search/repositories") ) { _ in
              return HTTPStubsResponse(
                  fileAtPath: OHPathForFile("sampleResponseBadRequest.json", type(of: self))!,
                  statusCode: 422,
                  headers: nil)
        }
        do {
            let repositoryList = try await GitHubAPIService.fetchRepository(for: "")
            XCTAssertNil(repositoryList)
        } catch (let error){
            XCTAssertNotNil(error)
            XCTAssert((error as Any) is GitHubAPIService.ServiceError)
            XCTAssertEqual(error as! GitHubAPIService.ServiceError, GitHubAPIService.ServiceError.badRequest)
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)

    }

    func testFetchRepositoriesNetworkError() async {
        let expectation = XCTestExpectation(description: "Fetching data from server")
        stub(condition: isHost("api.github.com") && isPath("/search/repositories") ) { _ in
          return HTTPStubsResponse(
            fileAtPath: OHPathForFile("sampleResponse.json", type(of: self))!,
            statusCode:200,
            headers:nil
          ).requestTime(200.0, responseTime: 5.0)
        }
        do {
            let repositoryList = try await GitHubAPIService.fetchRepository(for: "swift")
            XCTAssertNil(repositoryList)
        } catch (let error){
            XCTAssertNotNil(error)
            XCTAssert((error as Any) is GitHubAPIService.ServiceError)
            XCTAssertEqual(error as! GitHubAPIService.ServiceError, GitHubAPIService.ServiceError.network)

        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 300)

    }
    
    func testFetchRepositoriesParsingError() async {
        let expectation = XCTestExpectation(description: "Fetching data from server")
          stub(condition: isHost("api.github.com") && isPath("/search/repositories") ) { _ in
              return HTTPStubsResponse(
                  fileAtPath: OHPathForFile("sampleResponseParsingError.json", type(of: self))!,
                  statusCode: 200,
                  headers: nil)
        }
        do {
            let repositoryList = try await GitHubAPIService.fetchRepository(for: "Swift")
            XCTAssertNil(repositoryList)
        } catch (let error){
            XCTAssertNotNil(error)
            XCTAssert((error as Any) is GitHubAPIService.ServiceError)
            XCTAssertEqual(error as! GitHubAPIService.ServiceError, GitHubAPIService.ServiceError.parsing)
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)

    }
    
    
    override func tearDown() {
        HTTPStubs.removeAllStubs()
        super.tearDown()
    }

}
