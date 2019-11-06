//
//  PostsViewModel.swift
//  Reddit
//
//  Created by Nicolas Fernandez Amorosino on 05/11/2019.
//  Copyright © 2019 Nicolas Amorosino. All rights reserved.
//

import Foundation

class PostsViewModel {

    //MARK: - Private properties
    private var baseUrl = URL(string: "https://www.reddit.com/top/.json?limit=50")

    init() {
        guard let url = baseUrl else {
            return
        }

        fetchPosts(url: url, completion: { posts in
            print(posts)
        })
    }

    private func fetchPosts(url: URL, completion: (([Post]) -> Void)?) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                print("There was an error trying to fetch the posts")
                completion?([Post]())
                return
            }

            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    print("There was an error trying to parse the response data to dictionary")
                    completion?([Post]())
                    return
                }

                completion?(self.decodePosts(from: json))
            } catch {
                print("There was an error trying to parse the response data to dictionary")
            }
        }).resume()
    }

    private func decodePosts(from posts: [String: Any]) -> [Post] {
        var decodedPosts = [Post]()

        guard let jsonData = posts["data"] as? [String: Any],
            let postsJson = jsonData["children"] as? [[String: Any]] else {
                print("It's likely that we couldn't found some of the keys we're looking for")
                return decodedPosts
        }

        postsJson.forEach { postJson in
            guard let postData = postJson["data"] as? [String: Any] else {
                print("It's likely that we couldn't found some of the keys we're looking for")
                return
            }

            let author = postData["author"] as? String
            let title = postData["title"] as? String
            let creationDate = postData["created"] as? Double
            let thumbnail = postData["thumbnail"] as? String
            let numberOfComments = postData["num_comments"] as? Int
            let imageUrl = postData["url"] as? String

            let post = Post(author: author, title: title, creationDate: creationDate, thumbnail: thumbnail, numberOfComments: numberOfComments, status: false, imageUrl: imageUrl)

            decodedPosts.append(post)
        }

        return decodedPosts
    }
}
