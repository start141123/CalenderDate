//
//  ZHView.swift
//  ZHCalenderDate
//
//  Created by Ame on 2023/1/9.
//

import UIKit

class ZHView: UIView {

    let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        installSetupUI()
        installSetupSubscribe()
    }

    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
    }
    
    convenience init(width: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        snp.makeConstraints { (make) in
            make.width.equalTo(width)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        installSetupUI()
    }

    func installSetupSubscribe() {

    }

    func getCenter() -> CGPoint {
        return convert(center, from: superview)
    }
    
    func installSetupUI() {
        self.layer.masksToBounds = true
        setNeedsUpdateConstraints()
    }

}
