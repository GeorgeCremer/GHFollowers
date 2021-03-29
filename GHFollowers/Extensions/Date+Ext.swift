//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by George Cremer on 26/03/2021.
//

import Foundation

extension Date {
   
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
