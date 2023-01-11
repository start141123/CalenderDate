//
//  ZYCalendarWeekCell.swift
//  BreathLive
//
//  Created by Ame on 2022/12/28.
//

import UIKit

class ZYCalendarWeekCell: ZHCollectionViewCell<ZHCellViewModel> {
    
    public final func configCell(str: String) {
        dateLabel.text = str
    }
    
    override func installSetupUI() {
        super.installSetupUI()
        self.isSelected = false
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
        return label
    }()
}
