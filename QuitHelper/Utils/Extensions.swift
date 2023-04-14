//
//  Extensions.swift
//  QuitHelper
//
//  Created by 이보한 on 2023/03/31.
//

import Foundation

extension Date: RawRepresentable {
    public var rawValue: String {
        let formatter = ISO8601DateFormatter()
        return formatter.string(from: self)
    }

    public init?(rawValue: String) {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: rawValue) {
            self = date
        } else {
            return nil
        }
    }
}

extension DailyData {
    var dateOnly: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self.date ?? Date())
        return calendar.date(from: components)!
    }
}
