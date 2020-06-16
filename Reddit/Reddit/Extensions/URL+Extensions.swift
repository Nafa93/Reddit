//
//  URL+Extensions.swift
//  Reddit
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 6/15/20.
//  Copyright © 2020 Nicolas Amorosino. All rights reserved.
//

import Foundation

extension URL {
    func isAnImageLink() -> Bool {
        let imageExtensions = ["png", "jpg"]
        
        if imageExtensions.contains(self.pathExtension) {
            return true
        } else {
            return false
        }
    }
}
