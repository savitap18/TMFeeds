//
//  PostRequestClient.swift
//  TMFeeds
//
//  Created by Savi on 10/9/20.
//

import Foundation

final class Request {
    let baseURL = "http://www.reddit.com/.json"
    let session: URLSession
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}

extension Request: RequestProtocol {

    func fetchPosts(afterLink: String? = nil,
                    completion: @escaping (Result<FeedData, DataResponseError>) -> Void) {

        guard var urlComponents = URLComponents(string: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }

        if afterLink != nil {
            let queryItems = [URLQueryItem(name: "after", value: afterLink)]
            urlComponents.queryItems = queryItems
        }

        guard  let url =  urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }

        fetchPosts(url: url) { result in
            completion(result)
            return
        }
    }

    func fetchPosts(url: URL, completion: @escaping (Result<FeedData, DataResponseError>) -> Void) {

        let task = session.dataTask(with: url) { data, _, _ in

            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let feedResponses = try decoder.decode(Feed.self, from: data)
                let feedData = feedResponses.data
                completion(.success(feedData))
            } catch {
                completion(.failure(.decoding))
            }
        }
        task.resume()
    }
}
