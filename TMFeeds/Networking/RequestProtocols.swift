//
//  RequestProtocols.swift
//  TMFeeds
//
//  Created by Savi on 10/10/20.
//

import Foundation

protocol RequestProtocol {
    func fetchFeeds(afterLink: String?, completion: @escaping (Result<FeedData, DataResponseError>) -> Void)
}

enum DataResponseError: Error {
    case network
    case decoding
    case noData
    case invalidURL
    
    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data "
        case .decoding:
            return "An error occurred while decoding data"
        case .noData:
            return "No data is returned"
        case .invalidURL:
            return "Invalid URL"
        }
    }
}
