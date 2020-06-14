//
//  PostsViewController.swift
//  Reddit
//
//  Created by Nicolas Fernandez Amorosino on 05/11/2019.
//  Copyright © 2019 Nicolas Amorosino. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    typealias Strings = Constants.PostsViewController
    typealias Nibs = Constants.Nibs
    
    var viewModel = PostsViewModel(networkManager: NetworkManager())

    @IBOutlet var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Strings.title

        viewModel.delegate = self

        setupNavigationBar()
        setupRefreshControl()
        setupTable()
    }        
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Strings.rightBarButton, style: .plain, target: self, action: #selector(dismissAllPosts))
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(viewModel.getPosts), for: .valueChanged)
        postsTableView.refreshControl = refreshControl
    }
    
    private func setupTable() {
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.register(UINib(nibName: Nibs.postTableViewCell, bundle: nil), forCellReuseIdentifier: Nibs.postTableViewCell)
    }

    @objc func dismissAllPosts() {
        guard let count = viewModel.posts?.count else { return }

        var indexPaths = [IndexPath]()

        for index in stride(from: count - 1, through: 0, by: -1) {
            viewModel.posts?.remove(at: index)
            indexPaths.append(IndexPath(row: index, section: 0))
        }

        postsTableView.beginUpdates()
        postsTableView.deleteRows(at: indexPaths, with: .left)
        postsTableView.endUpdates()
    }
    
    func navigateToPostDetailViewController(_ post: Post?) {
        guard let post = post else { return }
        
        let postDetailViewController = PostDetailViewController()
        postDetailViewController.post = post
        postDetailViewController.title = post.author
        
        navigationController?.pushViewController(postDetailViewController, animated: true)
    }
}

// MARK: - Table View
extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Nibs.postTableViewCell, for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }

        cell.post = viewModel.posts?[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.posts?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = viewModel.posts?[indexPath.row]
        
        navigateToPostDetailViewController(selectedPost)
    }
}

// MARK: - PostViewModelDelegate functions
extension PostsViewController: PostsViewModelDelegate {
    func postsFetched() {
        DispatchQueue.main.async { [weak self] in
            self?.postsTableView.reloadData()
            self?.postsTableView.refreshControl?.endRefreshing()
        }
    }
}
