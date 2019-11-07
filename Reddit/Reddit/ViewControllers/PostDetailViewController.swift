//
//  PostDetailViewController.swift
//  Reddit
//
//  Created by Nicolas Fernandez Amorosino on 05/11/2019.
//  Copyright © 2019 Nicolas Amorosino. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {

    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var upVotes: UILabel!
    @IBOutlet weak var downVotes: UILabel!
    @IBOutlet weak var upVotesImage: UIImageView!
    @IBOutlet weak var downVotesImage: UIImageView!
    @IBOutlet weak var commentsAmount: UILabel!
    
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let post = post {
            author.text = "Posted by \(post.author ?? "") on /r/\(post.subreddit ?? "") \(post.creationDate?.getElapsedInterval() ?? "")"
            postTitle.text = post.title
            thumbnail.imageFromServerURL(url: post.thumbnail)
            upVotes.text = "\(post.ups ?? 0)"
            downVotes.text = "\(post.downs ?? 0)"
            downVotesImage.image = UIImage(named: "downArrow")
            upVotesImage.image = UIImage(named: "upArrow")
            commentsAmount.text = post.numberOfComments
        }
    }

}

