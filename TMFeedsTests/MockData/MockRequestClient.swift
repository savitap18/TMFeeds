//
//  MockRequestClient.swift
//  TMFeedsTests
//
//  Created by Savi on 10/10/20.
//

import Foundation
@testable import TMFeeds

class MockRequestClient: RequestProtocol {
    enum ResultType {
        case success
        case failure
    }
    var resultType: ResultType = .success

    func fetchFeeds(afterLink: String?, completion: @escaping (Result<FeedData, DataResponseError>) -> Void) {
        switch resultType {
        case .success:
            let testBundle = Bundle(for: type(of: self))
            if let path = testBundle.path(forResource: "mockData", ofType: "json") {
                if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path),
                                            options: .alwaysMapped),
                   let feedData = try? JSONDecoder().decode(Feed.self, from: jsonData) {
                    completion(.success(feedData.data))
                }
            }
        case .failure:
            completion(.failure(.decoding))
        }
    }
}
