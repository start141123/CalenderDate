//
//  ZYCalendarView.swift
//  BreathLive
//
//  Created by Ame on 2022/12/28.
//

import UIKit

enum CalendarSourceType {
    case lastMonth
    case lastYear
    case nextMonth
    case nextYear
}

class ZYCalendarView: ZHView {
    // MARK: - op
    let dateAction = PublishRelay<Date>()
    
    // MARK: - life
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews([weekCollectionCiew, dateCollectioinView, dividerView])
        weekCollectionCiew.snp.makeConstraints { make in
            make.centerX.width.top.equalToSuperview()
            make.height.equalTo(46~)
        }
        dateCollectioinView.snp.makeConstraints { make in
            make.centerX.width.bottom.equalToSuperview()
            make.top.equalTo(weekCollectionCiew.snp.bottom)
        }
        dividerView.snp.makeConstraints { make in
            make.centerX.width.equalToSuperview()
            make.top.equalTo(weekCollectionCiew.snp.bottom)
            make.height.equalTo(0.5~)
        }
    }
    
    override func installSetupSubscribe() {
        super.installSetupSubscribe()
        dateCollectioinView.selectedAction
            .subscribe(onNext: { [weak self] date in
                self?.dateAction.accept(date)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - public
    public final func modifySelectedDate(date: Date) {
        dateCollectioinView.modifySelectedDate(date: date)
    }
    
    public final func modifyBeforeDaysState(state: Bool) {
        dateCollectioinView.modifyBeforeDaysState(state: state)
    }
    
    public final func modifyMonth(type: CalendarSourceType, completion: ((Date) -> ())) {
        dateCollectioinView.modifyMonth(type: type, completion: completion)
    }
    // MARK: - lazy
    private lazy var weekCollectionCiew: ZYCalendarWeekView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 38~, height: 38~)
        layout.minimumLineSpacing = 13~
        layout.minimumInteritemSpacing = 13~
        layout.sectionInset = UIEdgeInsets(top: 4~, left: 12~, bottom: 4~, right: 12~)
        let view = ZYCalendarWeekView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    private lazy var dateCollectioinView: ZYCalendarDateView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 38~, height: 38~)
        layout.minimumLineSpacing = 10~
        layout.minimumInteritemSpacing = 13~
        layout.sectionInset = UIEdgeInsets(top: 12~, left: 12~, bottom: 12~, right: 12~)
        let view = ZYCalendarDateView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorEEEEEE
        return view
    }()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
