//
//  PostTableViewCell.swift
//  Reddit
//
//  Created by Nicolas Fernandez Amorosino on 05/11/2019.
//  Copyright © 2019 Nicolas Amorosino. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var numberOfComments: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var status: UIView!

    var post: Post? {
        didSet {
            configureView()
        }
    }

    func configureView() {
        guard let post = post else { return }

        author.text = "Posted by \(post.author) \(post.created.getElapsedInterval())"
        postTitle.text = post.title
        numberOfComments.text = "\(post.numberOfComments) Comments"
        thumbnail.imageFromServerURL(url: post.thumbnail)
        status.backgroundColor = post.status ? .white : .blueStatus

        thumbnail.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openImage)))
    }

    @objc func openImage() {
        if let url = post?.imageUrl {
            UIApplication.shared.open(url)
        }
    }
}
