//
//  Constants.swift
//  Reddit
//
//  Created by Nicolas Fernandez Amorosino on 05/11/2019.
//  Copyright © 2019 Nicolas Amorosino. All rights reserved.
//

import Foundation

class Constant {
    struct ErrorMessage {
        static let fetchingPosts = "There was an error trying to fetch the posts"
        static let parsingPosts = "There was an error trying to parse the response data to dictionary"
        static let missingKey = "It's likely that we couldn't found some of the keys we're looking for"
        static let missingUrl = "The URL used to fetch the posts is nil"
    }

    struct StatusCode {
        static let success = 200
    }
}
