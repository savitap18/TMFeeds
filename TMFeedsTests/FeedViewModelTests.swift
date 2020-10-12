//
//  PostViewModelTests.swift
//  TMFeedsTests
//
//  Created by Savi on 10/10/20.
//

import XCTest
@testable import TMFeeds

class FeedViewModelTests: XCTestCase {
    var fetchCompleted = false
    var fetchFailed = false
    var fetchExpectation: XCTestExpectation!
    
    override func setUpWithError() throws {
        fetchExpectation = expectation(description: "Should wait for Fetch Completion")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchPostSuccess() {
        let mockClient = MockRequestClient()
        mockClient.resultType = .success
        let viewModel = FeedsViewModel(client: mockClient)
        viewModel.fetchFeeds { (_) in
            self.fetchCompleted = true
            self.fetchExpectation.fulfill()
        }
        wait(for: [fetchExpectation], timeout: 15)
        XCTAssertTrue(fetchCompleted, "onFetchCompleted not invoked")
        XCTAssert(viewModel.getPostsCount() == 1, "Post count didn't match")
        XCTAssertNotNil(viewModel.getFeedCellViewModel(index: 0), "PostCellViewModel not initialized")
    }
    func testFetchPostFailure() {
        let mockClient = MockRequestClient()
        mockClient.resultType = .failure
        let viewModel = FeedsViewModel(client: mockClient)
        viewModel.fetchFeeds { (_) in
            self.fetchFailed = true
            self.fetchExpectation.fulfill()
        }
        wait(for: [fetchExpectation], timeout: 15)
        XCTAssertTrue(fetchFailed, "onFetchFailed not invoked")
    }
    //Note : Due to time constraint could not implement test cases for controller
}
