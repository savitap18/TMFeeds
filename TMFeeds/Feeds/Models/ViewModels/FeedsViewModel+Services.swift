//
//  FeedsViewModel+Services.swift
//  TMFeeds
//
//  Created by Savi on 10/10/20.
//

import Foundation

extension FeedsViewModel: FeedViewModelServices {
    
    /// Method called using viewModel instance to start fetching the feed data
    /// - Parameter completion: returns success or failure as true or false
    func fetchFeeds(completion: @escaping (Bool) -> Void) {
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        getFeeds(client: client) { (sucess) in
            completion(sucess)
        }
    }
    
    /// Method to fetch the feed data 
    /// - Parameters:
    ///   - client: Request client 
    ///   - completion: completion handler to return true/false
    func getFeeds(client: RequestProtocol, completion: @escaping (Bool) -> Void) {
        client.fetchFeeds(afterLink: afterLink) { result in
            self.isFetchInProgress = false
            switch result {
            case .failure:
                completion(false)
            case .success(let feedData):
                self.posts.append(contentsOf: feedData.children)
                self.afterLink = feedData.after
                completion(true)
            }
        }
    }
}
