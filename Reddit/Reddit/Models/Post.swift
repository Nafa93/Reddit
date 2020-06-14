//
//  Post.swift
//  Reddit
//
//  Created by Nicolas Fernandez Amorosino on 05/11/2019.
//  Copyright © 2019 Nicolas Amorosino. All rights reserved.
//

import Foundation

struct Post {
    let author: String?
    let title: String?
    let created: Date?
    let thumbnail: URL?
    let numberOfComments: Int?
    var status: Bool
    let imageUrl: URL?
    let subreddit: String?
    let upvotes: Int?
    let downvotes: Int?
}

extension Post: Decodable {
    
    private enum PostCodingKeys: String, CodingKey {
        case author
        case title
        case created
        case thumbnail
        case numberOfComments = "num_comments"
        case imageUrl = "url"
        case subreddit
        case upvotes = "ups"
        case downvotes = "downs"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PostCodingKeys.self)
        
        status = false
        
        let thumbnailString = try container.decode(String.self, forKey: .thumbnail)
        thumbnail = URL(string: thumbnailString)

        let imageUrlString = try container.decode(String.self, forKey: .imageUrl)
        imageUrl = URL(string: imageUrlString)
        
        let createdInt = try container.decode(Int.self, forKey: .created)
        created = Date(timeIntervalSince1970: Double(createdInt))
        
        author = try container.decode(String.self, forKey: .author)
        title = try container.decode(String.self, forKey: .title)
        numberOfComments = try container.decode(Int.self, forKey: .numberOfComments)
        subreddit = try container.decode(String.self, forKey: .subreddit)
        upvotes = try container.decode(Int.self, forKey: .upvotes)
        downvotes = try container.decode(Int.self, forKey: .downvotes)
    }
}
