//
//  ImageViewExtension.swift
//  Reddit
//
//  Created by Nicolas Fernandez Amorosino on 06/11/2019.
//  Copyright © 2019 Nicolas Amorosino. All rights reserved.
//

import UIKit

extension UIImageView {

    public func imageFromServerURL(url: URL?) {

        guard let url = url else {
            image = UIImage(named: "imageNotFound")
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) -> Void in

            if error != nil {
                DispatchQueue.main.async {
                    self?.image = UIImage(named: "imageNotFound")
                }
                print(error?.localizedDescription as Any)
                return
            }

            DispatchQueue.main.async(execute: { [weak self] in
                guard let data = data else { return }

                self?.image = UIImage(data: data)
            })

        }).resume()
    }
}
