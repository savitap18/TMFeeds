//
//  FeedProtocols.swift
//  TMFeeds
//
//  Created by Savi on 10/11/20.
//

import Foundation

protocol FeedsViewModelDelegate: class {
    func onFetchCompleted()
    func onFetchFailed()
}

protocol FeedViewModelServices {
    func fetchFeeds(completion: @escaping (Bool) -> Void)
    func getFeeds(client: RequestProtocol, completion: @escaping (Bool) -> Void)
}

protocol FeedsViewControllerDelegate: class {
    func configureUI()
    func configureData()
    func showSpinner()
    func removeSpinner()
}
