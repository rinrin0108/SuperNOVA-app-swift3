//
//  AlertUtil.swift
//  SuperNOVA-app
//
//  Created by t-kurasawa on 2016/09/24.
//  Copyright © 2016年 SuperNOVA. All rights reserved.
//

import UIKit

class AlertUtil {
    
    /// OKボタンのみ表示するアラートビューを生成する<br>
    /// OKボタンを押下しても何もイベントは起こさない
    static func alertError(_ view: UIViewController, title: String, message: String) {
        let alert:UIAlertController = UIAlertController(title: title,
                                                        message: message,
                                                        preferredStyle: UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction(title: NSLocalizedString("ALERT_BUTTON_OK", comment: ""),
            style: UIAlertActionStyle.cancel,
            handler: nil)
        );
        view.present(alert, animated: true, completion: nil)
    }
    
    /// OKボタン、キャンセルボタンを表示するアラートビューを生成する<br>
    /// OKボタン押下時のイベントを設定できる<br>
    /// キャンセルボタンを押下しても何もイベントは起こさない
    static func alertConfirm(_ view: UIViewController, title: String, message: String, handler: @escaping (UIAlertAction) -> Void) {
        let alert:UIAlertController = UIAlertController(title: title,
                                                        message: message,
                                                        preferredStyle: UIAlertControllerStyle.alert);
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("ALERT_BUTTON_OK", comment: ""),
            style: UIAlertActionStyle.default,
            handler: handler)
        );
        alert.addAction(UIAlertAction(title: NSLocalizedString("ALERT_BUTTON_CANCEL", comment: ""),
            style: UIAlertActionStyle.cancel,
            handler: nil)
        );
        view.present(alert, animated: true, completion: nil)
    }
}
