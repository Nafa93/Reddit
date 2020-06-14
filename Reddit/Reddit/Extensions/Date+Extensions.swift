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

        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())

        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year) year ago" : "\(year) years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month) month ago" : "\(month) months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day) day ago" : "\(day) days ago"
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour) hour ago" : "\(hour) hours ago"
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute) minute ago" : "\(minute) minutes ago"
        } else if let second = interval.second, second > 0 {
            return second == 1 ? "\(second) second ago" : "\(second) secounds ago"
        } else {
            return "a moment ago"
        }

    }
}
