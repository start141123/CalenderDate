//
//  Date_Ex.swift
//  ZHCalenderDate
//
//  Created by Ame on 2023/1/9.
//

import UIKit

extension Date {
    
    // MARK: - 获取当前日期到指定间隔时间间隔的日期
    static func getExpectTimestamp(year: Int, month: Int, day: Int, hour: Int = 0, min: Int = 0) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = Formatter.yyyyMdHm.rawValue
        formatter.locale = NSLocale.system
        formatter.calendar = Calendar(identifier: .gregorian)
        let date = formatter.string(from: Date())
        let currentdata = formatter.date(from: date) ?? Date()
        let calendar = Calendar(identifier: .gregorian)
        var datecomps = DateComponents()
        datecomps.year = year
        datecomps.month = month
        datecomps.day = day
        datecomps.hour = hour
        datecomps.minute = min
        if let calculatedate = calendar.date(byAdding: datecomps, to: currentdata) {
            return calculatedate
        } else {
            return nil
        }
    }
    
    // MARK: - 获取指定开始日期到指定间隔时间间隔的日期
    static func getExpectTimestampWith(currentdata: Date, year: Int, month: Int, day: Int) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = Formatter.yMd.rawValue
        formatter.locale = NSLocale.system
        formatter.calendar = Calendar(identifier: .gregorian)
        let date = formatter.string(from: currentdata)
        let currentdata = formatter.date(from: date) ?? Date()
        let calendar = Calendar(identifier: .gregorian)
        var datecomps = DateComponents()
        datecomps.year = year
        datecomps.month = month
        datecomps.day = day
        if let calculatedate = calendar.date(byAdding: datecomps, to: currentdata) {
            return calculatedate
        } else {
            return nil
        }
    }

    /// 获取两个日期之间的所有日期，精确到天
    /// - Parameters:
    ///   - leftDateStr: 最小时间
    ///   - rightDateStr: 最大时间
    static func getDayArray(leftDate: Date, rightDate: Date) -> [Date] {
        var start = leftDate
        let calendar = Calendar(identifier: .gregorian)
        var componentAarray: [Date] = []
        var result = start.compare(rightDate)
        var comps = DateComponents()
        while result != .orderedDescending {
            comps = calendar.dateComponents([.year, .month, .day, .weekday], from: start)
            if let day = comps.day {
                componentAarray.append(start)
                comps.day = day + 1
                start = calendar.date(from: comps)!
                result = start.compare(rightDate)
            }
        }
        return componentAarray
    }
    
    // 计算两个日期差，返回当前日期与指定日期差
    static func checkDiff(diffDate: Date) -> Int {
        return checkDiffCustomDate(startDate: Date(), diffDate: diffDate)
    }
    
    static func checkDiffCustomDate(startDate: Date, diffDate: Date) -> Int {
        let formatter = DateFormatter()
        let calendar = Calendar.current
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = NSLocale.system
        formatter.calendar = Calendar(identifier: .gregorian)
        // 开始日期
        let startDate = formatter.date(from: formatter.string(from: startDate))
        // 指定日期
        let endDate = formatter.date(from: formatter.string(from: diffDate))
        let diff: DateComponents = calendar.dateComponents([.day], from: startDate!, to: endDate!)
        return diff.day!
    }
    
    /// 获取指定日期格式化字符串
    /// - Parameters:
    ///   - date: 指定日期
    ///   - dateFormat: 日期格式
    /// - Returns: 格式化后的字符串
    static func dateWithString(date: Date, dateFormat: String) -> String {
        let format = DateFormatter()
        format.dateFormat = dateFormat
        format.locale = NSLocale.system
        format.calendar = Calendar(identifier: .gregorian)
        return format.string(from: date)
    }
    
    enum Formatter: String {
        case yyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
        case yyMdHm = "yy-MM-dd HH:mm"
        case yyyyMdHm = "yyyy-MM-dd HH:mm"
        case yMd = "yyyy-MM-dd"
        case mdHms = "MM-dd HH:mm:ss"
        case mdHm = "MM-dd HH:mm"
        case hms = "HH:mm:ss"
        case hhmm = "HH:mm"
        case mmdd = "MM-dd"
        case yyMd = "yy-MM-dd"
        case YYMMdd = "yyyyMMdd"
        case yyyyMdHms = "yyyyMMddHHmmss"
        case yyyyMdHmsS = "yyyy-MM-dd HH:mm:ss.SSS"
        case yyyyMMddHHmmssSSS = "yyyyMMddHHmmssSSS"
        case yMdWithSlash = "yyyy/MM/dd"
        case yyyyMM = "yyyy-MM"
        case yMdChangeSeparator = "yyyy.MM.dd"
        case yyyy = "yyyy"
        case mmss = "mm:ss"
        case yyMMddHHmmss = "yyyy.MM.dd HH:mm:ss"
        case dd = "d"
        case cnYYYYMM = "yyyy年MM月"
        case cnYYYYMMdd = "yyyy年MM月dd日"
        case cnYYYYMMHHmm = "yyyy年MM月dd日 HH时mm分"
        case cnHHmm = "HH时mm分"
    }
}
