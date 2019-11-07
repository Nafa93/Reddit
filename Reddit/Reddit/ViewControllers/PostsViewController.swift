//
//  PostsViewController.swift
//  Reddit
//
//  Created by Nicolas Fernandez Amorosino on 05/11/2019.
//  Copyright © 2019 Nicolas Amorosino. All rights reserved.
//

import UIKit

class PostsViewController: UITableViewController {

    var viewModel = PostsViewModel()
    var detailViewController: PostDetailViewController? = nil
    var objects = [Any]()

    @IBOutlet var postsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        navigationItem.leftBarButtonItem = editButtonItem

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? PostDetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

}

extension PostsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let post = sender as? Post
        if segue.identifier == "showDetail" {
            let controller = (segue.destination as! UINavigationController).topViewController as! PostDetailViewController
            controller.post = post
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
}

// MARK: - Table View
extension PostsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {
            print(Constant.ErrorMessage.cell)
            return UITableViewCell()
        }
        
        cell.delegate = self
        cell.post = viewModel.posts?[indexPath.row]
        cell.author.text = viewModel.posts?[indexPath.row].author

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.posts?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension PostsViewController: PostsViewModelDelegate {
    func postsFetched() {
        DispatchQueue.main.async { [weak self] in
            self?.postsTableView.reloadData()
        }
    }
}

extension PostsViewController: PostTableViewCellDelegate {
    func segueToPostDetail(post: Post?) {
        performSegue(withIdentifier: "showDetail", sender: post)
    }
}
