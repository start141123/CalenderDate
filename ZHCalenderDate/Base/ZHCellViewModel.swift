//
//  ZHCellViewModel.swift
//  ZHCalenderDate
//
//  Created by Ame on 2023/1/11.
//

import UIKit

class ZHCellViewModel: NSObject {
    
    // MARK: - synchronized 锁
    public final func synchronized(_ lockObject: Any, closure: voidBlock) {
        objc_sync_enter(lockObject)
        closure()
        objc_sync_exit(lockObject)
    }
    
}
