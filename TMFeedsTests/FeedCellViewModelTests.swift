//
//  PostCellViewModelTests.swift
//  TMFeedsTests
//
//  Created by Savi on 10/11/20.
//

import XCTest
@testable import TMFeeds

class FeedCellViewModelTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func getMockPostData () -> PostData? {
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: "mockData", ofType: "json") {
            if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped),
               let feedData = try? JSONDecoder().decode(Feed.self, from: jsonData) {
                return feedData.data.children.first?.data
            }
        }
        return nil
    }

    func testInitializer() {
        guard let data = getMockPostData() else {
            XCTFail("Failed to get mock data")
            return
        }
        let model = FeedCellViewModel(postData: data)
        XCTAssertNotNil(model, "Model is not initialized")
        XCTAssert(model.title == "Toph for sure", "Title not set properly")
        XCTAssert(model.score == 21625, "Score not set properly")
        XCTAssert(model.commentsCount == 759, "Comments count not set properly")
        XCTAssert(model.imageURLString == "https://b.thumbs.redditmedia.com/tGnTBhmo9PUR1aDVRxEgEZmDywsY2PjqpJ4LBt-6-oI.jpg",
                  "Image URL not set properly")
        XCTAssert(model.ratio == 1.0, "Ratio not set properly")
    }

}
