//
//  UIColorExtension.swift
//  SuperNOVA-app
//
//  Created by Atsushi Hayashida on 2016/11/07.
//  Copyright © 2016年 SuperNOVA. All rights reserved.
//

import UIKit

extension UIColor {
    class func rgb(r: Int, g: Int, b: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    class func origin_orangeColor() -> UIColor {
        return UIColor.rgb(r: 230, g: 110, b: 68, alpha: 1.0)
    }
    class func origin_greenColor() -> UIColor {
        return UIColor.rgb(r: 118, g: 176, b: 91, alpha: 1.0)
    }
}
