//
//  ZYCalendarWeekView.swift
//  BreathLive
//
//  Created by Ame on 2022/12/28.
//

import UIKit

class ZYCalendarWeekView: ZHCollectionView {
    // MARK: - op
    private var weekSource = ["日", "一", "二", "三", "四", "五", "六"]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(cellWithClass: ZYCalendarWeekCell.self)
        self.backgroundColor = UIColor.white
        self.delegate = self
        self.dataSource = self
        self.showsVerticalScrollIndicator = false
        self.isScrollEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }   
}

extension ZYCalendarWeekView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ZYCalendarWeekCell.self, for: indexPath)
        if let model = self.weekSource[safe: indexPath.row] {
            cell.configCell(str: model)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
