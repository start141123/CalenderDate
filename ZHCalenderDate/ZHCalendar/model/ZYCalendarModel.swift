//
//  ZYCalendarModel.swift
//  BreathLive
//
//  Created by Ame on 2022/12/28.
//

import UIKit

struct ZYCalendarModel: Codable {
    var date: Date?
    var isEnable: Bool = true
    var selectedDate = Date()
    
    init(date: Date, isEnable: Bool) {
        self.date = date
        self.isEnable = isEnable
    }
}
