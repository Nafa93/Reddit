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

        viewModel.delegate = self
        title = "Posts"
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dismiss All", style: .plain, target: self, action: #selector(dismissAllPosts))

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)

        postsTableView.refreshControl = refreshControl

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? PostDetailViewController
        }
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
        viewModel.refreshPosts()
    }
}

// MARK: - Segue preparation
extension PostsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let post = sender as? Post

        if segue.identifier == "showDetail" {
            let controller = (segue.destination as! UINavigationController).topViewController as! PostDetailViewController
            controller.post = post
            controller.title = post?.author
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
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
        
        cell.delegate = self
        cell.post = viewModel.posts?[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.posts?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
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

// MARK: - PostTableViewCellDelegate functions
extension PostsViewController: PostTableViewCellDelegate {
    func segueToPostDetail(post: Post?) {
        performSegue(withIdentifier: "showDetail", sender: post)
    }
}
