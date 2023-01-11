//
//  ZHCalendarDateView.swift
//  BreathLive
//
//  Created by Ame on 2022/12/28.
//

import UIKit

class ZYCalendarDateView: ZHCollectionView {
    // MARK: - op
    // MARK: - 指定日期所在月份日期
    private var curMonthDate: Date = Date()
    // MARK: - 指定日期所在月份的天数
    private var curMonthDays: Int = 0
    
    // MARK: - 指定日期所在月份的第一天是星期几
    private var weekday: Int = 0
    
    private var dateSource: [ZYCalendarModel] = []
    
    private var selectedIndexPath: IndexPath?
    private var selectedDate: Date = Date()
    private var beforeDaysState = false
    
    let selectedAction = PublishRelay<Date>()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(cellWithClass: ZYCalenderCell.self)
        self.backgroundColor = UIColor.white
        self.delegate = self
        self.dataSource = self
        self.showsVerticalScrollIndicator = false
        self.isScrollEnabled = false
        self.configDateSource()
    }
    
    // MARK: - public
    // MARK: - 更新当前选中的日期
    public final func modifySelectedDate(date: Date) {
        self.selectedDate = date
    }
    
    // MARK: - 今天日期之前的日期是否置灰  true: 置灰  false: 不置灰
    public final func modifyBeforeDaysState(state: Bool) {
        self.beforeDaysState = state
        self.configDateSource()
    }
    
    public final func modifyMonth(type: CalendarSourceType, completion: ((Date) -> ())) {
        switch type {
        case .lastMonth:
            self.getLastMonth(month: 1)
        case .lastYear:
            self.getLastMonth(month: 12)
        case .nextMonth:
            self.getNextMonth(month: 1)
        case .nextYear:
            self.getNextMonth(month: 12)
        }
        self.configDateSource()
        completion(self.curMonthDate)
    }
    
    // MARK: - private
    private func configDateSource() {
        guard
            let startDate = getFirstDayDate(self.curMonthDate),
            let endDate = getLastDayDate(self.curMonthDate)
        else {return}
        var firSource: [Date] = []
        var nextSource: [Date] = []
        
        self.weekday = getFirstDayInDateMonth(self.curMonthDate)
        if weekday != 0 {
            let firstLastDate =  Date.getExpectTimestampWith(currentdata: startDate, year: 0, month: 0, day: -1)
            let firstDate = Date.getExpectTimestampWith(currentdata: startDate, year: 0, month: 0, day: -(weekday))
            firSource = Date.getDayArray(leftDate: firstDate!, rightDate: firstLastDate!)
        }
        let curMonthSource = Date.getDayArray(leftDate: startDate, rightDate: endDate)
        synchronized(dateSource, cb_xclosure: {
            dateSource.removeAll()
            if !firSource.isEmpty {
                for item in firSource {
                    let model = ZYCalendarModel(date: item, isEnable: false)
                    dateSource.append(model)
                }
            }
            for item in curMonthSource {
                if self.beforeDaysState {
                    let comDay = Date.checkDiff(diffDate: item)
                    if comDay < 0 {
                        let model = ZYCalendarModel(date: item, isEnable: false)
                        dateSource.append(model)
                    } else {
                        let model = ZYCalendarModel(date: item, isEnable: true)
                        dateSource.append(model)
                    }
                } else {
                    let model = ZYCalendarModel(date: item, isEnable: true)
                    dateSource.append(model)
                }
            }
            if dateSource.count < 42 {
                let gapCount = 42 - dateSource.count
                let nextLastDate =  Date.getExpectTimestampWith(currentdata: endDate, year: 0, month: 0, day: 1)
                let nextDate = Date.getExpectTimestampWith(currentdata: endDate, year: 0, month: 0, day: gapCount)
                nextSource = Date.getDayArray(leftDate: nextLastDate!, rightDate: nextDate!)
                for item in nextSource {
                    let model = ZYCalendarModel(date: item, isEnable: false)
                    dateSource.append(model)
                }
            }
            self.reloadData()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZYCalendarDateView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ZYCalenderCell.self, for: indexPath)
        if let model = self.dateSource[safe: indexPath.row] {
            cell.configCell(model: model, selectedDate: self.selectedDate)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let model = self.dateSource[safe: indexPath.row], model.isEnable, let date = model.date else {return}
        self.selectedDate = date
        if let selected = self.selectedIndexPath {
            collectionView.reloadItems(at: [selected])
            collectionView.reloadItems(at: [indexPath])
        } else {
            collectionView.reloadData()
        }
        self.selectedIndexPath = indexPath
        selectedAction.accept(date)
    }
}

extension ZYCalendarDateView {
    // MARK: - 获取指定月份的天数
    private func calculateDaysInDateMonth(_ date: Date) -> Int {
        let calendar = Calendar(identifier: .gregorian)
        let specifiedDateCom = calendar.dateComponents([.year,.month,.day], from: date)
        
        var startCom = DateComponents()
        startCom.day = 1
        startCom.month = specifiedDateCom.month
        startCom.year = specifiedDateCom.year
        let startDate = calendar.date(from: startCom)
        
        var endCom = DateComponents()
        endCom.day = 1
        endCom.month = specifiedDateCom.month == 12 ? 1 : specifiedDateCom.month! + 1
        endCom.year = specifiedDateCom.month == 12 ? specifiedDateCom.year! + 1 : specifiedDateCom.year
        let endDate = calendar.date(from: endCom)
        
        let days = calendar.dateComponents([.day], from: startDate!, to: endDate!)
        let count = days.day ?? 0
        return count
    }
    
    // MARK: - 获取指定日期所在月份的第一天是星期几
    private func getFirstDayInDateMonth(_ date: Date) -> Int {
        let calendar = Calendar(identifier: .gregorian)
        var specifiedDateCom = calendar.dateComponents([.year,.month], from: date)
        specifiedDateCom.setValue(1, for: .day)
        let startOfMonth = calendar.date(from: specifiedDateCom)
        let weekDayCom = calendar.component(.weekday, from: startOfMonth!)
        return weekDayCom - 1
    }
    
    // MARK: - 获取指定日期所在月份的第一天日期
    private func getFirstDayDate(_ date: Date) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var specifiedDateCom = calendar.dateComponents([.year,.month], from: date)
        specifiedDateCom.setValue(1, for: .day)
        let startOfMonth = calendar.date(from: specifiedDateCom)
        return startOfMonth
    }
    
    // MARK: - 获取指定日期所在月份的最后一天的日期
    private func getLastDayDate(_ date: Date) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var specifiedDateCom = calendar.dateComponents([.year,.month], from: date)
        let days = self.calculateDaysInDateMonth(date)
        specifiedDateCom.setValue(days, for: .day)
        let endOfMonth = calendar.date(from: specifiedDateCom)
        return endOfMonth
    }
    
    // MARK: - 获取上个月的同一日期
    private func getLastMonth(month: Int) {
        let calendar = Calendar.init(identifier: .gregorian)
        var comLast = DateComponents()
        comLast.setValue(-month, for: .month)
        self.curMonthDate = calendar.date(byAdding: comLast, to: self.curMonthDate)!
        self.curMonthDays = calculateDaysInDateMonth(self.curMonthDate)
    }
    
    // MARK: - 获取下个月的同一日期
    private func getNextMonth(month: Int) {
        let calendar = Calendar.init(identifier: .gregorian)
        var comLast = DateComponents()
        comLast.setValue(+month, for: .month)
        self.curMonthDate = calendar.date(byAdding: comLast, to: self.curMonthDate)!
        self.curMonthDays = calculateDaysInDateMonth(self.curMonthDate)
    }
    
    // MARK: - 锁
    private func synchronized(_ lockObject: Any, cb_xclosure: voidBlock) {
        objc_sync_enter(lockObject)
        cb_xclosure()
        objc_sync_exit(lockObject)
    }
}
