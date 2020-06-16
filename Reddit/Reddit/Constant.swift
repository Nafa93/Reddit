//
//  Constants.swift
//  Reddit
//
//  Created by Nicolas Fernandez Amorosino on 05/11/2019.
//  Copyright © 2019 Nicolas Amorosino. All rights reserved.
//

import Foundation

struct Constants {
    struct PostsViewController {
        static let title = "Posts"
        static let rightBarButton = "Dismiss All"
        
        struct Alert {
            static let title = "Something went wrong"
            static let cancelButton = "Cancel"
            static let reloadButton = "Reload"
        }
    }
    
    struct Nibs {
        static let postViewController = "PostsViewController"
        static let postTableViewCell = "PostTableViewCell"
    }
}
