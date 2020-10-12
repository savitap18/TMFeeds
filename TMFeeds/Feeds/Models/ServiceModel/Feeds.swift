//
//  Feeds.swift
//  TMFeeds
//
//  Created by Savi on 10/10/20.
//

import Foundation
struct Feed: Codable {
    let data: FeedData
}

struct FeedData: Codable {
    let children: [Post]
    let after: String?
}

struct Post: Codable {
    let data: PostData
}

struct PostData: Codable {
    let title: String
    let image: String
    let imageWidth: Int?
    let imageHeight: Int?
    let score: Int
    let commentsCount: Int
    enum CodingKeys: String, CodingKey {
        case title
        case score
        case image = "thumbnail"
        case imageWidth = "thumbnail_width"
        case imageHeight = "thumbnail_height"
        case commentsCount = "num_comments"
    }
}
