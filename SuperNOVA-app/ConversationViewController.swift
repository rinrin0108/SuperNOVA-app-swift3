//
//  ConversationViewController.swift
//  SuperNOVA-app
//
//  Created by t-kurasawa on 2016/09/25.
//  Copyright © 2016年 SuperNOVA. All rights reserved.
//

import Foundation
import UIKit

class ConversationViewController: UIViewController {
    
    
    @IBOutlet weak var photo_student: UIImageView!
    @IBOutlet weak var photo_teacher: UIImageView!
    @IBOutlet weak var name_teacher: UILabel!
    @IBOutlet weak var name_student: UILabel!
    
    override func viewDidLoad() {
        var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        //生徒
        self.name_student.text = appDelegate._fullname
        self.photo_student.image =  API.downloadImage(appDelegate._image)
        self.photo_student.layer.cornerRadius = self.photo_student.frame.size.width / 2
        //教師
        self.name_teacher.text = appDelegate._partnerName
        self.photo_teacher.image =  API.downloadImage(appDelegate._partnerimage)
        self.photo_teacher.layer.cornerRadius = self.photo_teacher.frame.size.width / 2

    }
    
    @IBAction func start(_ sender: UIButton) {
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        
        //ピッチング終了リクエスト
        MergerAPI.finishPitching(appDelegate._id ,sync: true,
                                       success:{
                                        values in let closure = {
                                            NSLog("---ConversationViewController MergerAPI.finishPitching success");
                                            // 通信は成功したが、エラーが返ってきた場合
                                            if(API.isError(values)){
                                                NSLog("---ConversationViewController MergerAPI.finishPitching isError");
                                                /**
                                                 * ストーリーボードをまたぐ時に値を渡すためのもの（Indicatorストーリーボードを作成する必要あり）
                                                 Indicator.windowClose()
                                                 */
                                                AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),
                                                    message: values["errorMessage"] as! String)
                                                return
                                            }
                                            
                                            NSLog(values.debugDescription);
                                            
                                        }
                                        // 通知の監視
                                        if(!Thread.isMainThread){
                                            NSLog("---ConversationViewController !NSThread.isMainThread() in success");
                                            DispatchQueue.main.sync {
                                                NSLog("---ConversationViewController dispatch_sync");
                                                closure()
                                            }
                                        } else {
                                            NSLog("---ConversationViewController dispatch_sync else");
                                            // 恐らく実行されない
                                            closure()
                                        }
                                        
            },
                                       failed: {
                                        id, message in let closure = {
                                            NSLog("---ConversationViewController MergerAPI.finishPitching failed");
                                            /**
                                             * ストーリーボードをまたぐ時に値を渡すためのもの（Indicatorストーリーボードを作成する必要あり）
                                             Indicator.windowClose()
                                             */
                                            // 失敗した場合エラー情報を表示
                                            if(id == -2) {
                                                AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),
                                                    message: NSLocalizedString("MAX_FILE_SIZE_OVER", comment: ""));
                                            } else {
                                                AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),
                                                    message: NSLocalizedString("ALERT_MESSAGE_NETWORK_ERROR", comment: ""));
                                            }
                                        }
                                        // 通知の監視
                                        if(!Thread.isMainThread){
                                            NSLog("---ConversationViewController !NSThread.isMainThread() in failed");
                                            DispatchQueue.main.sync {
                                                NSLog("---ConversationViewController dispatch_sync");
                                                closure()
                                            }
                                        } else {
                                            NSLog("---ConversationViewController dispatch_sync else");
                                            //恐らく実行されない
                                            closure()
                                        }
            }
        )

        
        
        ViewShowAnimation.changeViewWithIdentiferFromHome(self, toVC: "toEvaluateView")
    }
}
