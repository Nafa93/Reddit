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

        fetchPosts(url: url, completion: nil)
    }

    func fetchPosts(url: URL, completion: (([Post]) -> Void)?) {
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

                print(json)
            } catch {
                print("There was an error trying to parse the response data to dictionary")
            }
        }).resume()
    }
}
