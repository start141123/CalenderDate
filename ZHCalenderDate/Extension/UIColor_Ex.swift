//
//  UIColor_Ex.swift
//  ZHCalenderDate
//
//  Created by Ame on 2023/1/11.
//

import UIKit

extension UIColor {
    /// 红绿蓝转Color对象
    ///
    /// - Parameters:
    ///   - rgbValue: 红绿蓝色值
    ///   - alpha: alpha通道值
    /// - Returns: UIColor对象
    class func colorFromRGB(rgbValue: Int, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255,
                            green: CGFloat((rgbValue & 0xFF00) >> 8) / 255,
                            blue: CGFloat(rgbValue & 0xFF) / 255,
                            alpha: alpha)
    }
}
