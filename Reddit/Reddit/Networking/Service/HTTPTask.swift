//
//  HTTPTask.swift
//  Reddit
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 6/11/20.
//  Copyright © 2020 Nicolas Amorosino. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParamaters: Parameters?, urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
}
