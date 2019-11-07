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

    var delegate: PostTableViewCellDelegate?
    var post: Post?

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(performSegue)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc
    func performSegue() {
        delegate?.segueToPostDetail(post: post)
    }
    
}
