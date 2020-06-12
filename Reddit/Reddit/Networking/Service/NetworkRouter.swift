//
//  NetworkRouter.swift
//  Reddit
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 6/11/20.
//  Copyright © 2020 Nicolas Amorosino. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
