//
//  Validation.swift
//  SuperNOVA-app
//
//  Created by t-kurasawa on 2017/02/03.
//  Copyright © 2017年 SuperNOVA. All rights reserved.
//

import Foundation

final class Validation {
    
    //nilチェック nil is true
    static func isNil(_ param: NSObject?) -> Bool {
        if param != nil{
            return false
        }
        return true
    }
}
