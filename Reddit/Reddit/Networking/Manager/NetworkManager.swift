//
//  NetworkManager.swift
//  Reddit
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 6/11/20.
//  Copyright © 2020 Nicolas Amorosino. All rights reserved.
//

import Foundation

struct NetworkManager {
    private let router = Router<RedditAPI>()
}

enum NetworkResponse: String {
    case success
}

enum NetworkErrorResponse: String, Error {
    case badRequest = "Bad Request."
    case failed = "Failed."
    case unableToDecode = "We couldn't decode the response."
    case noData = "There's no data in the response."
}

extension NetworkManager {
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<NetworkResponse, NetworkErrorResponse> {
        
        switch response.statusCode {
            case 200...299: return .success(.success)
            case 501...599: return .failure(.badRequest)
            default: return .failure(.failed)
        }
    }
    
    func getTopPosts(amount: Int, completion: @escaping (_ posts: [Post]?, _ error: NetworkErrorResponse?) -> ()) {
        router.request(.topPosts(amount: 50), completion: { data, response, error in
            if error != nil {
                completion(nil, .failed)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success(let successMessage):
                    print(successMessage)
                    
                    guard let responseData = data else {
                        completion(nil, .noData)
                        return
                    }
                    
                    
                    do {
                        var posts = [Post]()
                        
                        guard let mainData = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any],
                              let dataChildren = mainData["data"] as? [String: Any],
                              let children = dataChildren["children"] as? [[String: Any]] else {
                            completion(nil, .unableToDecode)
                            return
                        }
                        
                        for data in children {
                            guard let postJson = data["data"] else {
                                completion(nil, .unableToDecode)
                                return
                            }
                            
                            let postData = try JSONSerialization.data(withJSONObject: postJson, options: [])
                            
                            let post = try JSONDecoder().decode(Post.self, from: postData)
                            
                            posts.append(post)
                        }
                        
                        completion(posts, nil)
                    } catch {
                        completion(nil, .unableToDecode)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        })
    }
}
