//
//  UIImage+Extensions.swift
//  Reddit
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 6/16/20.
//  Copyright © 2020 Nicolas Amorosino. All rights reserved.
//

import UIKit

extension UIImage {
    public class var imageNotFound: UIImage? {
        return UIImage(named: "imageNotFound")
    }
    
    public class var downArrow: UIImage? {
        return UIImage(named: "downArrow")
    }
    
    public class var upArrow: UIImage? {
        return UIImage(named: "upArrow")
    }
}
