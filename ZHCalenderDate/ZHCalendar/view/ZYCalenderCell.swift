//
//  ZYCalenderCell.swift
//  BreathLive
//
//  Created by Ame on 2022/12/28.
//

import UIKit

class ZYCalenderCell: ZHCollectionViewCell<ZHCellViewModel> {
    
    public final func configCell(model: ZYCalendarModel, selectedDate: Date) {
        guard let date = model.date else {return}
        let temp = Date.dateWithString(date: date, dateFormat: Date.Formatter.dd.rawValue)
        self.dateLabel.text = temp
        
        let selectedComDay = Date.checkDiffCustomDate(startDate: date, diffDate: selectedDate)
        if selectedComDay == 0, model.isEnable {
            self.dateLabel.textColor = ColorFFFFFF
            self.dateLabel.backgroundColor = ColorF93D3F
        } else {
            let comDay = Date.checkDiff(diffDate: date)
            if comDay == 0, model.isEnable {
                self.dateLabel.textColor = ColorF93D3F
                self.dateLabel.backgroundColor = ColorF93D3F1
            } else {
                if model.isEnable {
                    self.dateLabel.textColor = Color333333
                } else {
                    self.dateLabel.textColor = ColorCCCCCC
                }
                self.dateLabel.backgroundColor = ColorFFFFFF
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = ""
    }
    
    override func installSetupUI() {
        super.installSetupUI()
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color333333
        label.font = Font15
        label.textAlignment = .center
        label.numberOfLines = 1
        label.cornerRadius = 4
        return label
    }()
}
