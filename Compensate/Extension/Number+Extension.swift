//
//  Number+Extension.swift
//  Compensate
//
//  Created on 25.5.2020.
//  Copyright © 2020 Compensate. All rights reserved.
//

import Foundation

extension Int64 {
    var toReadableDateString: String {
        let createdDate = Date(timeIntervalSince1970: TimeInterval(self))
        
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "hh:mm a, dd MMM yyyy"
        
        return formatter.string(from: createdDate)
    }
}
