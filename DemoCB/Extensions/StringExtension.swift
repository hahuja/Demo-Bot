//
//  StringExtension.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 04/03/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation

extension String {
    func stringToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //Your date format
        if let date = dateFormatter.date(from: self) {
            return date
        }
        return nil
    }
}
