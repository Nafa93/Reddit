//
//  Date+Extensions.swift
//  Reddit
//
//  Created by Nicolas Fernandez Amorosino on 06/11/2019.
//  Copyright © 2019 Nicolas Amorosino. All rights reserved.
//

import Foundation

extension Date {
    func getElapsedInterval() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
