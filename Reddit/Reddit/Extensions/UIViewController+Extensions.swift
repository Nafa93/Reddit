//
//  UIViewController+Extensions.swift
//  Reddit
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 6/15/20.
//  Copyright © 2020 Nicolas Amorosino. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
        for action in actions {
            alertController.addAction(action)
        }
    
        self.present(alertController, animated: true, completion: nil)
  }
}
