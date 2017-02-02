//
//  EncounterViewController.swift
//  SuperNOVA-app
//
//  Created by t-kurasawa on 2016/09/25.
//  Copyright © 2016年 SuperNOVA. All rights reserved.
//

import Foundation
import UIKit

class EncounterViewController: UIViewController {
    
    @IBOutlet weak var photo_student: UIImageView!
    @IBOutlet weak var photo_teacher: UIImageView!
    @IBOutlet weak var name_student: UILabel!
    @IBOutlet weak var name_teacher: UILabel!
    @IBOutlet weak var time_label: UILabel!
    
    @IBOutlet weak var start_btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        
        //時間
        //self.time_label.text = appDelegate._time + ":00"
        countNum = appDelegate._time * 6000
        self.time_label.text = timeFormat(countNum)
        
        //生徒
        self.name_student.text = appDelegate._fullname
        self.photo_student.image =  API.downloadImage(appDelegate._image)
        self.photo_student.layer.cornerRadius = self.photo_student.frame.size.width / 2
        self.photo_student.clipsToBounds = true
        self.photo_student.layer.borderColor = UIColor.green.cgColor
        
        //教師
        UserAPI.getUser(appDelegate._partner,sync: true,
            success:{
                values in let closure = {
                    NSLog("---EncounterViewController UserAPI.getUser success");
                    // 通信は成功したが、エラーが返ってきた場合
                    if(API.isError(values)){
                        NSLog("---EncounterViewController UserAPI.getUser isError");
                        /**
                         *  ストーリーボードをまたぐ時に値を渡すためのもの（Indicatorストーリーボードを作成する必要あり）
                            Indicator.windowClose()
                         */
                        AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),
                                                message: values["errorMessage"] as! String)
                        return
                    }
                    
                    if values.isEmpty == true {
                        // 誰ともマッチしなかった場合
                        print("no result-----------")
                        ViewShowAnimation.changeViewWithIdentiferFromHome(self, toVC: "backToMap")
                        return
                    }
                    
                    NSLog(values.debugDescription);
                    appDelegate._partnerimage = values["image"] as! String
                    appDelegate._partnerName = values["fullname"] as! String
                    self.photo_teacher.image =  API.downloadImage(appDelegate._partnerimage)
                    self.photo_teacher.layer.cornerRadius = self.photo_teacher.frame.size.width / 2
                    self.photo_teacher.clipsToBounds = true
                    self.photo_teacher.layer.borderColor = UIColor.orange.cgColor
                    self.name_teacher.text = appDelegate._partnerName
                }
                
                // 通知の監視
                if(!Thread.isMainThread){
                    NSLog("---EncounterViewController !NSThread.isMainThread() in success");
                    DispatchQueue.main.sync {
                        NSLog("---EncounterViewController dispatch_sync");
                        closure()
                    }
                } else {
                        NSLog("---EncounterViewController dispatch_sync else");
                        closure()   // 恐らく実行されない
                }
                                    
            },
            failed: {
                id, message in let closure = {
                    NSLog("---EncounterViewController UserAPI.getUser failed");
                    // 失敗した場合エラー情報を表示
                    if(id == -2) {
                        AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),message: NSLocalizedString("MAX_FILE_SIZE_OVER", comment: ""));
                    } else {
                        AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),message: NSLocalizedString("ALERT_MESSAGE_NETWORK_ERROR", comment: ""));
                    }
                }
                // 通知の監視
                if(!Thread.isMainThread){
                    NSLog("---EncounterViewController !NSThread.isMainThread() in failed");
                    DispatchQueue.main.sync {
                        NSLog("---EncounterViewController dispatch_sync");
                        closure()
                    }
                } else {
                        NSLog("---EncounterViewController dispatch_sync else");
                        closure()   //恐らく実行されない
                }
            }
        )
    }
    
    var timerOn = false
    var nsTimer = Timer()
    var countNum :Int = 0
    
    @IBAction func start(_ sender: UIButton) {
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        
        
        //ピッチングの開始時間を更新
        let now = Date() // 現在日時の取得
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmm"
        NSLog(dateFormatter.string(from: now))
        
        let starttime :String! = dateFormatter.string(from: now)
        MergerAPI.updatePitchStarttime(appDelegate._id , starttime: starttime ,sync: true,
            success:{
                values in let closure = {
                    NSLog("---EncounterViewController MergerAPI.updatePitchStarttime success");
                    // 通信は成功したが、エラーが返ってきた場合
                    if(API.isError(values)){
                        NSLog("---EncounterViewController MergerAPI.updatePitchStarttime isError");
                        /**
                         *  ストーリーボードをまたぐ時に値を渡すためのもの（Indicatorストーリーボードを作成する必要あり）
                            Indicator.windowClose()
                         */
                        AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),message: values["errorMessage"] as! String)
                        return
                    }
                    NSLog(values.debugDescription);
                                            
                }
                // 通知の監視
                if(!Thread.isMainThread){
                    NSLog("---EncounterViewController !NSThread.isMainThread() in success");
                    DispatchQueue.main.sync {
                        closure()
                    }
                } else {
                    NSLog("---EncounterViewController closure");
                    closure()   // 恐らく実行されない
                }
            },
            failed: {
                id, message in let closure = {
                    NSLog("---EncounterViewController MergerAPI.updatePitchStarttime failed");
                    /**
                     *  ストーリーボードをまたぐ時に値を渡すためのもの（Indicatorストーリーボードを作成する必要あり）
                        Indicator.windowClose()
                     */
                    // 失敗した場合エラー情報を表示
                    if(id == -2) {
                        AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),message: NSLocalizedString("MAX_FILE_SIZE_OVER", comment: ""));
                    } else {
                        AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),
                            message: NSLocalizedString("ALERT_MESSAGE_NETWORK_ERROR", comment: ""));
                    }
                }
                // 通知の監視
                if(!Thread.isMainThread){
                    NSLog("---EncounterViewController !NSThread.isMainThread() in failed");
                    DispatchQueue.main.sync {
                        NSLog("---EncounterViewController dispatch_sync");
                        closure()
                    }
                } else {
                        NSLog("---EncounterViewController dispatch_sync else");
                        closure()   //恐らく実行されない
                }
            }
        )
        
        if timerOn == false {
            nsTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(EncounterViewController.update), userInfo: nil, repeats: true)
            timerOn = true
            start_btn.setTitle("Enjoy NOVA!", for: UIControlState.normal)
            start_btn.isUserInteractionEnabled = false
            start_btn.setBackgroundImage(UIImage(named: "btn_gray"), for: UIControlState.normal)
            NSLog("Tap to start")
        }else{
            nsTimer.invalidate()
            timerOn = false
            start_btn.setTitle("START", for: UIControlState.normal)
            NSLog("Tap to stop")
        }
        
    }
    
    func update() {
        countNum -= 1
        self.time_label.text = timeFormat(countNum)
        if(countNum <= 0){
            //start_btn.setTitle("END", for: UIControlState.normal)
            //start_btn.setBackgroundImage(UIImage(named: "btn_green"), for: UIControlState.normal)
            
            ViewShowAnimation.changeViewWithIdentiferFromHome(self, toVC: "toConversationView")
        }
    }
    
    func timeFormat(_ num :Int)-> String {
        //        if num < 0 { num = 0 }
        let num = num
        let ms = num % 100
        let s = (num - ms) / 100 % 60
        let m = (num - s - ms) / 6000 % 3600
        //return String(format: "%02d:%02d.%02d", arguments: [m,s,ms])
        return String(format: "%02d:%02d", arguments: [m,s])
    }
}
