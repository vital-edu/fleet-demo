//
//  DateUtils.swift
//  Fleet
//
//  Created by Eduardo Vital Alencar Cunha on 12/05/2022.
//

import Foundation

class DateUtils {
    static var fullDateTimeFormatter: ISO8601DateFormatter {
        let localISOFormatter = ISO8601DateFormatter()
        localISOFormatter.formatOptions = [.withFullDate, .withFullTime, .withSpaceBetweenDateAndTime]
        localISOFormatter.timeZone = TimeZone.current
        return localISOFormatter
    }

    static var dayMonthYearFormatter: DateFormatter {
        let localISOFormatter = DateFormatter()
        localISOFormatter.dateFormat = "dd/MM/yyyy"
        localISOFormatter.timeZone = TimeZone.current
        return localISOFormatter
    }

    static var yearMonthDayFormatter: ISO8601DateFormatter {
        let localISOFormatter = ISO8601DateFormatter()
        localISOFormatter.formatOptions = [.withFullDate]
        localISOFormatter.timeZone = TimeZone.current
        return localISOFormatter
    }
}
