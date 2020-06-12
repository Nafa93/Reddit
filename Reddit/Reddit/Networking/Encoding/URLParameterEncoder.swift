//
//  URLParameterEncoder.swift
//  Reddit
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 6/11/20.
//  Copyright © 2020 Nicolas Amorosino. All rights reserved.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingUrl }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for(key, value) in parameters {
                let urlQueryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                
                urlComponents.queryItems?.append(urlQueryItem)
            }
            
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlEncoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
