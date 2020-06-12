//
//  RedditEndPoint.swift
//  Reddit
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 6/11/20.
//  Copyright © 2020 Nicolas Amorosino. All rights reserved.
//

import Foundation

public enum RedditAPI {
    case topPosts(amount: Int)
}

extension RedditAPI: EndPointType {
    var baseUrl: URL {
        guard let url = URL(string: "https://www.reddit.com/") else {
            fatalError("Base URL couldn't be created")
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .topPosts(_):
            return "top/.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .topPosts(let amount):
            return .requestParameters(bodyParamaters: nil, urlParameters: ["limit": "\(amount)"])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
