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
    
    func testFetchRepositoriesSuccess() {
      let expectation = XCTestExpectation(description: "Fetching data from server")
        stub(condition: isHost("api.github.com") && isPath("/search/repositories") ) { _ in
            return HTTPStubsResponse(
                fileAtPath: OHPathForFile("sampleResponse.json", type(of: self))!,
                statusCode: 200,
                headers: nil
            )
      }
        GitHubAPIService.fetchRepository(for: "swift") { result in
            switch result {
            case .success(let items):
                XCTAssert((items as Any) is [Repository])
                XCTAssertEqual(items.count, 30)
                XCTAssertEqual(items.first?.id, 44838949)
                expectation.fulfill()
                
            case .failure(let error):
                XCTAssert((error as Any) is GitHubAPIService.ServiceError)
                expectation.fulfill()
            }
      }
      wait(for: [expectation], timeout: 5)
    }
    
    
    func testFetchRepositoriesParsingError() {
        let expectation = XCTestExpectation(description: "Fetching data from server")
          stub(condition: isHost("api.github.com") && isPath("/search/repositories") ) { _ in
              return HTTPStubsResponse(
                  fileAtPath: OHPathForFile("sampleResponseParsingError.json", type(of: self))!,
                  statusCode: 422,
                  headers: nil)
        }
          GitHubAPIService.fetchRepository(for: "swift") { result in
              XCTAssertEqual(result,.failure(GitHubAPIService.ServiceError.parsing))
              expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)

    }

    func testFetchRepositoriesNetworkError() {
        let expectation = XCTestExpectation(description: "Fetching data from server")
        stub(condition: isHost("api.github.com") && isPath("/search/repositories") ) { _ in
          return HTTPStubsResponse(
            fileAtPath: OHPathForFile("sampleResponse.json", type(of: self))!,
            statusCode:200,
            headers:nil
          ).requestTime(200.0, responseTime: 5.0)
        }
          GitHubAPIService.fetchRepository(for: "swift") { result in
              XCTAssertEqual(result,.failure(GitHubAPIService.ServiceError.network))
              expectation.fulfill()

        }
        wait(for: [expectation], timeout: 300)

    }
    

    func testFetchRepositoriesSuccessPerformance() throws {
        
        measure(
            metrics: [
                XCTClockMetric(),
                XCTCPUMetric(),
                XCTStorageMetric(),
                XCTMemoryMetric()
            ]
        ) { [weak self] in
            guard let self = self else { return }
            self.testFetchRepositoriesSuccess()
        }
    }
    
    
    override func tearDown() {
        HTTPStubs.removeAllStubs()
        super.tearDown()
    }

}
