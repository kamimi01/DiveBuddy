//
//  Date+.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-09-14.
//

import Foundation

enum DateTemplate: String {
    case date = "yMd"
}

extension DateFormatter {
    func setTemplate(_ template: DateTemplate) {
        dateFormat = DateFormatter.dateFormat(fromTemplate: template.rawValue, options: 0, locale: .current)
    }
}

extension Date {
    func format(with template: DateTemplate) -> String {
        let formatter = DateFormatter()
        formatter.setTemplate(template)
        return formatter.string(from: self)
    }
}
