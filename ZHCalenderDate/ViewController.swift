//
//  ViewController.swift
//  ZHCalenderDate
//
//  Created by Ame on 2023/1/9.
//

import UIKit

class ViewController: ZHViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        installSetupUI()
        installSetupSubscribe()
    }
    
    override func installSetupSubscribe() {
        super.installSetupSubscribe()
        lastYearBtn.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                self?.dateCollectioinView.modifyMonth(type: .lastYear, completion: {
                    self?.dateLab.text = Date.dateWithString(date: $0, dateFormat: Date.Formatter.cnYYYYMM.rawValue)
                })
            })
            .disposed(by: disposeBag)
        
        lastMonthBtn.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                self?.dateCollectioinView.modifyMonth(type: .lastMonth, completion: {
                    self?.dateLab.text = Date.dateWithString(date: $0, dateFormat: Date.Formatter.cnYYYYMM.rawValue)
                })
            })
            .disposed(by: disposeBag)
        
        nextMonthBtn.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                self?.dateCollectioinView.modifyMonth(type: .nextMonth, completion: {
                    self?.dateLab.text = Date.dateWithString(date: $0, dateFormat: Date.Formatter.cnYYYYMM.rawValue)
                })
            })
            .disposed(by: disposeBag)
        
        nextYearBtn.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                self?.dateCollectioinView.modifyMonth(type: .nextYear, completion: {
                    self?.dateLab.text = Date.dateWithString(date: $0, dateFormat: Date.Formatter.cnYYYYMM.rawValue)
                })
            })
            .disposed(by: disposeBag)
        
        dateCollectioinView.dateAction
            .subscribe(onNext: { [weak self] date in
                print("选择的时间  \(date)")
                self?.selectedTimeLab.text = date.dateString(ofStyle: .full)
            })
            .disposed(by: disposeBag)
    }
    
    override func installSetupUI() {
        super.installSetupUI()
        view.addSubviews([dateCollectioinView, dateLab, lastYearBtn, lastMonthBtn, nextMonthBtn, nextYearBtn, selectedTimeLab])
        dateLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(64~)
        }
        lastYearBtn.snp.makeConstraints { make in
            make.left.equalTo(12~)
            make.size.equalTo(20~)
            make.centerY.equalTo(dateLab.snp.centerY)
        }
        lastMonthBtn.snp.makeConstraints { make in
            make.centerY.size.equalTo(lastYearBtn)
            make.left.equalTo(lastYearBtn.snp.right).offset(18~)
        }
        nextYearBtn.snp.makeConstraints { make in
            make.centerY.size.equalTo(lastYearBtn)
            make.right.equalTo(-12~)
        }
        nextMonthBtn.snp.makeConstraints { make in
            make.centerY.size.equalTo(lastYearBtn)
            make.right.equalTo(nextYearBtn.snp.left).offset(-18~)
        }
        dateCollectioinView.snp.makeConstraints { make in
            make.centerX.width.equalToSuperview()
            make.top.equalTo(100~)
            make.height.equalTo(346~)
        }
        selectedTimeLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateCollectioinView.snp.bottom).offset(40~)
        }
    }
    
    private lazy var dateCollectioinView: ZYCalendarView = {
        let view = ZYCalendarView()
        return view
    }()
    
    private let dateLab = UILabel().then {
        $0.text = Date.dateWithString(date: Date(), dateFormat: Date.Formatter.cnYYYYMM.rawValue)
        $0.textColor = Color333333
        $0.font = FontMedium18
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let lastMonthBtn = UIButton(type: .custom).then {
        $0.imageForNormal = UIImage(named: "accompanying_operation_last_month")
    }
    
    private let lastYearBtn = UIButton(type: .custom).then {
        $0.imageForNormal = UIImage(named: "accompanying_operation_last_year")
    }
    
    private let nextMonthBtn = UIButton(type: .custom).then {
        $0.imageForNormal = UIImage(named: "accompanying_operation_next_month")
    }
    
    private let nextYearBtn = UIButton(type: .custom).then {
        $0.imageForNormal = UIImage(named: "accompanying_operation_next_year")
    }
    
    private let selectedTimeLab = UILabel().then {
        $0.text = Date().dateString(ofStyle: .full)
        $0.textColor = Color333333
        $0.font = FontMedium15
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
}
