//
//  PostsViewController.swift
//  Compensate
//
//  Created on 23.5.2020.
//  Copyright © 2020 Compensate. All rights reserved.
//

import UIKit
import SafariServices

class PostsViewController: UIViewController {
    
    // MARK: - Dependencies
    var viewModel: PostsViewModel!
    
    // MARK: - Private properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    private var shouldShowEmptyView = false
    private var errorString: String = ""
    private var posts = [Post]()
    
    private var isFirstTimeLoadedDone = false
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard !isFirstTimeLoadedDone else { return }
        
        viewModel.getPosts()
        isFirstTimeLoadedDone = true
    }
    
    // MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.refreshControl = refreshControl
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func binding() {
        viewModel.newPosts = { [weak self] newPosts in
            self?.posts = newPosts
        }
        
        viewModel.error = { [weak self] errorString in
            self?.errorString = errorString
        }
        
        viewModel.isFetching = { [weak self] isFetching in
            guard self?.refreshControl.isRefreshing == false, isFetching else { return }
            self?.refreshControl.beginRefreshing()
        }
        
        viewModel.shouldShowEmptyView = { [weak self] shouldShowEmptyView in
            self?.shouldShowEmptyView = shouldShowEmptyView
            
            DispatchQueue.main.async {
                self?.tableView.reloadDataAnimated()
            }
        }
    }
    
    @objc private func refresh() {
        viewModel.getPosts()
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if shouldShowEmptyView {
            self.tableView.setEmptyMessage(errorString)
        } else {
            self.tableView.restore()
        }

        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        
        cell.isLastPost = indexPath.row == (posts.count - 1)
        cell.post = posts[indexPath.row]
        cell.updateUI()
        
        cell.openUrlCallback = { [weak self] urlString in
            if let url = URL(string: urlString) {
                let viewController = SFSafariViewController(url: url)
                viewController.delegate = self
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        
        if let url = URL(string: post.content.permalink.toOpenUrlString) {
            let viewController = SFSafariViewController(url: url)
            viewController.delegate = self
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}

// MARK: - SFSafariViewControllerDelegate
extension PostsViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        navigationController?.popViewController(animated: true)
    }
    
}
