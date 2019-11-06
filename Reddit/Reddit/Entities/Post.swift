//
//  Post.swift
//  Reddit
//
//  Created by Nicolas Fernandez Amorosino on 05/11/2019.
//  Copyright © 2019 Nicolas Amorosino. All rights reserved.
//

import Foundation

class Post {
    var author: String
    var title: String
    var creationDate: Date
    var thumbnail: URL
    var numberOfComments: String
    var status: Bool
    var imageUrl: URL

    init(author: String, title: String, creationDate: Date, thumbnail: URL, numberOfComments: String, status: Bool, imageUrl: URL) {
        self.author = author
        self.title = title
        self.creationDate = creationDate
        self.thumbnail = thumbnail
        self.numberOfComments = numberOfComments
        self.status = status
        self.imageUrl = imageUrl
    }
}
