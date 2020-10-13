//
//  FeedsViewModel.swift
//  TMFeeds
//
//  Created by Savi on 10/10/20.
//

import Foundation

class FeedsViewModel {
    
    lazy var posts: [Post] = []
    internal var afterLink: String?
    internal let client: RequestProtocol
    internal var isFetchInProgress = false
    
    init(client: RequestProtocol = NetworkRequest()) {
        self.client = client
    }

    func getPostsCount() -> Int {
        posts.count
    }
    
    /// To create model to populate the TableView Cell's UI
    /// - Parameter index: row of the tableview that needs to be populated
    /// - Returns: CellViewModel object needed to populate the cell.
    func getFeedCellViewModel(index: Int) -> FeedCellViewModel {
        FeedCellViewModel(postData: posts[index].data)
    }
}
