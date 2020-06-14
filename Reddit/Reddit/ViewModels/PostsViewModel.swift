//
//  PostsViewModel.swift
//  Reddit
//
//  Created by Nicolas Fernandez Amorosino on 05/11/2019.
//  Copyright © 2019 Nicolas Amorosino. All rights reserved.
//

import Foundation

protocol PostsViewModelDelegate {
    func postsFetched()
}

class PostsViewModel {

    //MARK: - Public properties
    var delegate: PostsViewModelDelegate?
    var posts: [Post]?
    var networkManager: NetworkManager!

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        
        refreshPosts()
    }

    func refreshPosts() {
        networkManager.getTopPosts(amount: 50, completion: { [weak self] posts, error in
            if let error = error {
                print(error)
            }
            
            self?.posts = posts
            self?.delegate?.postsFetched()
        })
    }
}
