//
//  Fade.swift
//  SuperNOVA-app
//
//  Created by t-kurasawa on 2016/11/08.
//  Copyright © 2016年 SuperNOVA. All rights reserved.
//

import UIKit

public extension UIView {
    
    /**
     Fade in a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeIn(duration duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, delay:1.0, animations: {
            self.alpha = 1.0
        })
    }
    
    /**
     Fade out a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeOut(duration duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, delay:1.0, animations: {
            self.alpha = 0.0
        })
    }
    
}
