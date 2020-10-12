//
//  FeedCellViewModel.swift
//  TMFeeds
//
//  Created by Savi on 10/10/20.
//
import UIKit

struct FeedCellViewModel {
    
    private let postData: PostData
    
    init(postData: PostData) {
        self.postData = postData
    }
    
    var ratio: CGFloat {
        guard let height = postData.imageHeight, let width = postData.imageWidth else {
            return 1.0
        }
        return CGFloat(height)/CGFloat(width)
    }
    
    var height: CGFloat {
        let width = UIScreen.main.bounds.size.width
        let totalPadding = CGFloat(16)
        let height = (width - totalPadding) * ratio
        return height
    }
    
    var imageURLString: String {
        postData.image
    }
    
    var title: String {
        postData.title
    }
    
    var commentsCount: Int {
        postData.commentsCount
    }
    
    var score: Int {
        postData.score
    }
}
