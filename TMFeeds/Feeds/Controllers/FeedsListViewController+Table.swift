//
//  FeedsListViewController+Table.swift
//  TMFeeds
//
//  Created by Savi on 10/11/20.
//

import Foundation
import UIKit

extension FeedsListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getPostsCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier,
                                                       for: indexPath) as? FeedTableViewCell else {
            fatalError(#function)
        }
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none)
        } else {
            cell.configure(with: viewModel.getFeedCellViewModel(index: indexPath.row))
        }
        return cell
    }
}

extension FeedsListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            fetchData()
        }
    }
}

private extension FeedsListViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.getPostsCount() - 1
    }
}
