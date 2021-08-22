//
//  DataFormatter.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 22.08.2021.
//

import Foundation

// Check static
class DataFormatter {
    func changeDateFormat(changedDate: String, oldFormat: String, newFormat: String) -> String? {
        guard let date = getDateFromString(format: oldFormat, date: changedDate) else { return nil }
        let dateString = getStringDate(format: newFormat, date: date)
        return dateString
    }
    
    func getDateFromString(format: String, date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: date)
    }

    func getStringDate(format: String, date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    func decimalFormatting(number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","

        if let formattedNumber = formatter.string(for: number) {
            return formattedNumber
        }
        
        return String(number)
    }
}
