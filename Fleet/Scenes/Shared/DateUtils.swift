//
//  DateUtils.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import Foundation

class DateUtils {
    private(set) static var formatter: ISO8601DateFormatter = {
        let localISOFormatter = ISO8601DateFormatter()
        localISOFormatter.formatOptions = [.withFullDate, .withFullTime, .withSpaceBetweenDateAndTime]
        localISOFormatter.timeZone = TimeZone.current
        return localISOFormatter
    }()
}
