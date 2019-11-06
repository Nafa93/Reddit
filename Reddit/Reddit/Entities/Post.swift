//
//  Post.swift
//  Reddit
//
//  Created by Nicolas Fernandez Amorosino on 05/11/2019.
//  Copyright © 2019 Nicolas Amorosino. All rights reserved.
//

import Foundation

class Post {
    var author: String?
    var title: String?
    var creationDate: Date?
    var thumbnail: URL?
    var numberOfComments: String?
    var status: Bool?
    var imageUrl: URL?

    init(author: String?, title: String?, creationDate: Double?, thumbnail: String?, numberOfComments: Int?, status: Bool?, imageUrl: String?) {
        self.author = "u/\(author ?? "")"
        self.title = title
        self.creationDate = Date(timeIntervalSince1970: creationDate ?? 0)
        self.thumbnail = URL(string: thumbnail ?? "default")
        self.numberOfComments = "\(numberOfComments ?? 0) comments"
        self.status = status
        self.imageUrl = URL(string: imageUrl ?? "default")
    }
}
