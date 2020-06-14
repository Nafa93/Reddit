//
//  PostsViewController.swift
//  Reddit
//
//  Created by Nicolas Fernandez Amorosino on 05/11/2019.
//  Copyright © 2019 Nicolas Amorosino. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var viewModel = PostsViewModel(networkManager: NetworkManager())
    var detailViewController: PostDetailViewController? = nil

    @IBOutlet var postsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        postsTableView.delegate = self
        postsTableView.dataSource = self
        viewModel.delegate = self
        title = "Posts"
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dismiss All", style: .plain, target: self, action: #selector(dismissAllPosts))

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)

        postsTableView.refreshControl = refreshControl
        
        postsTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @objc
    func dismissAllPosts() {
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

    @objc
    func refreshPosts() {
        viewModel.getPosts()
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
extension PostsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {
            print(Constant.ErrorMessage.cell)
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
