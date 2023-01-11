//
//  ZHViewController.swift
//  ZHCalenderDate
//
//  Created by Ame on 2023/1/11.
//

import UIKit

class ZHViewController: UIViewController {
    // MARK: - op
    var disposeBag = DisposeBag()
    
    // MARK: - circle life
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        installSetupUI()
        installSetupSubscribe()
        installSetupBindViewModel()
    }
    
    public func installSetupUI() {
        
    }
    
    public func installSetupSubscribe() {
        
    }
    
    public func installSetupBindViewModel() {
        
    }
    
    deinit {
        print("\(type(of: self)): 销毁")
    }
}
