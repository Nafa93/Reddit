//
//  PostTableViewCell.swift
//  Reddit
//
//  Created by Nicolas Fernandez Amorosino on 05/11/2019.
//  Copyright © 2019 Nicolas Amorosino. All rights reserved.
//

import UIKit

protocol PostTableViewCellDelegate {
    func segueToPostDetail(post: Post?)
}

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var numberOfComments: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var status: UIView!

    var delegate: PostTableViewCellDelegate?
    var post: Post? {
        didSet {
            configureView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(performSegue)))
    }

    @objc
    func performSegue() {

        // Updating post status
        post?.status = true
        configureView()

        delegate?.segueToPostDetail(post: post)
    }

    func configureView() {
        guard let post = post else { return }

        author.text = "Posted by \(post.author ?? "") \(post.creationDate?.getElapsedInterval() ?? "")"
        postTitle.text = post.title
        numberOfComments.text = post.numberOfComments
        thumbnail.imageFromServerURL(url: post.thumbnail)
        status.backgroundColor = post.status ? .white : UIColor(displayP3Red: 24/255, green: 76/255, blue: 186/255, alpha: 1)

        thumbnail.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openImage)))
    }

    @objc
    func openImage() {
        if let url = post?.imageUrl {
            UIApplication.shared.open(url)
        }
    }
}
