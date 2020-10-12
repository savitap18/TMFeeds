//
//  FeedsListViewController.swift
//  TMFeeds
//
//  Created by Savi on 10/10/20.
//

import UIKit
class FeedsListViewController: UITableViewController {
    
    lazy var viewModel = FeedsViewModel()
    private var shouldShowLoadingCell = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configureUI()
    }
    
    /// Method to fetch feed
    func fetchData() {
        if isReachable() == false {
            removeSpinner()
            return
        }
        viewModel.fetchFeeds { [weak self] (sucess) in
            guard let self = self else {
                return
            }
            if sucess {
                self.onFetchCompleted()
            } else {
                self.onFetchFailed()
            }
        }
    }
}

extension FeedsListViewController: FeedsViewControllerDelegate {
    
    func configureData() {
        showSpinner()
        fetchData()
    }
    
    func isReachable() -> Bool {
        do {
            let connection = try Reachability().connection
            if connection ==  Reachability.Connection.unavailable{
                let alert = UIAlertController(title: "Error", message: "No Network Connection available", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return false
            }
        } catch {
            Logger.log(message:"Error in reaching")
        }
        return true
    }
    
    func configureUI() {
        self.title = "Feeds"
        
        func configureBackgroundColor() {
            let backgroundColor = UIColor(red: 234/255, green: 42/255, blue: 135/255, alpha: 1)
            self.view.backgroundColor = backgroundColor
            navigationController?.navigationBar.barTintColor = backgroundColor
        }
        
        func configureTable() {
            tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
            tableView.separatorStyle = .none
            tableView.showsVerticalScrollIndicator = false
            tableView.prefetchDataSource = self
            tableView.estimatedRowHeight = 200
            tableView.rowHeight = UITableView.automaticDimension
            tableView.separatorStyle = .none
        }
        configureBackgroundColor()
        configureTable()
    }
    
    func showSpinner() {
        DispatchQueue.main.async {
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.translatesAutoresizingMaskIntoConstraints = false
            spinner.tag = 9999
            spinner.hidesWhenStopped = true
            spinner.startAnimating()
            self.view.addSubview(spinner)
            spinner.center = self.view.center
        }
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            if let spinner = self.view.subviews.filter({ $0.tag == 9999}).first as? UIActivityIndicatorView {
                spinner.stopAnimating()
                spinner.removeFromSuperview()
            }
        }
    }
}

extension FeedsListViewController: FeedsViewModelDelegate {
    
    func onFetchCompleted() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.removeSpinner()
            self.tableView.reloadData()
        }
    }
    
    func onFetchFailed() {
        DispatchQueue.main.async {  [weak self] in
            guard let self = self else {
                return
            }
            self.removeSpinner()
        }
    }
}
