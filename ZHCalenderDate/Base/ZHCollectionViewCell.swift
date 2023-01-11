//
//  ZHCollectionViewCell.swift
//  ZHCalenderDate
//
//  Created by Ame on 2023/1/9.
//

import UIKit

typealias voidBlock = () -> Void

class ZHCollectionViewCell<T: ZHCellViewModel>: UICollectionViewCell {
    
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        installSetupUI()
    }

    override func prepareForReuse() {
        super .prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func installSetupSubscribe() {

    }

    func bind(to cellViewModel: T) {

    }
    
    func installSetupUI() {
        layer.masksToBounds = true
        installSetupSubscribe()
        setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
