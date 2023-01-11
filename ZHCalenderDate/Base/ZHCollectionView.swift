//
//  ZHCollectionView.swift
//  ZHCalenderDate
//
//  Created by Ame on 2023/1/9.
//

import UIKit

class ZHCollectionView: UICollectionView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        installSetupUI()
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        installSetupUI()
    }
    init() {
        super.init(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
        installSetupUI()
    }
    
    func installSetupUI() {
        layer.masksToBounds = true
        backgroundColor = .white
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
    }

}
