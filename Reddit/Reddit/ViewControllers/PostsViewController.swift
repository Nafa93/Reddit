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
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = editButtonItem

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? PostDetailViewController
        }

        registerTableViewCell()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    func registerTableViewCell() {
        let postTableViewCell = UINib(nibName: "PostTableViewCell", bundle: nil)
        postsTableView.register(postTableViewCell, forCellReuseIdentifier: "PostTableViewCell")
    }
}

// MARK: - Segues
extension PostsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let post = viewModel.posts?[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! PostDetailViewController
                controller.post = post
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
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

        cell.textLabel?.text = viewModel.posts?[indexPath.row].author

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
