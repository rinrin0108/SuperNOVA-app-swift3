//
//  LoginViewController.swift
//  SuperNOVA-app
//
//  Created by t-kurasawa on 2016/09/24.
//  Copyright © 2016年 SuperNOVA. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        //キャッシュを消す
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得

        appDelegate._id = "";
    }
    
    //ログイン認可を行う。アプリに登録されている情報からからユーザー情報を取得する。（NSUserDefaults永続化）
    func searchLoginData() -> [String : Any]? {
        NSLog("---LoginViewController searchLoginData")
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        
        let defaults = UserDefaults.standard;
        let user = defaults.dictionary(forKey: "User")
        if(user != nil){
            for (key, value) in user! {
                NSLog("\(key)：\(value)")
                if(key == "userid"){
                    appDelegate._userid   = value as! String
                }else if(key == "image"){
                    appDelegate._image    = value as! String
                }else if(key == "fullname"){
                    appDelegate._fullname = value as! String
                }else{
                    NSLog("---LoginViewController what is this data ?")
                }
            }
        }
        return user;
    }
    
    /**
     * ログインボタン押下時
     **/
    @IBAction func pushLogin(_ sender: UIButton) {
        NSLog("---LoginViewController pushLogin");
        
        //ログイン認可を行う。アプリに登録されている情報からからユーザー情報を取得する。（NSUserDefaults永続化）
        if(self.searchLoginData() != nil){
            NSLog("---LoginViewController Login with AppData");
            //ログインが成功
            ViewShowAnimation.changeViewWithIdentiferFromHome(self, toVC: "toMapView")
        }else{
            NSLog("---LoginViewController Login with Facebook");
            //ログイン認証を行う
            NSLog("---FacebookSDK version \(FBSDKSettings .sdkVersion())")
            let login : FBSDKLoginManager = FBSDKLoginManager.init()
            login.logIn(withReadPermissions: ["public_profile", "email"], from: self,
                        handler: {
                            result, error in
                            let closure = {
                                if ((error) != nil)
                                {
                                    NSLog("---LoginViewController pushLogin error");
                                    NSLog(error.debugDescription);
                                    // 失敗した場合エラー情報を表示
                                    AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),
                                                         message: NSLocalizedString("ALERT_LOGIN_FAILED_ERROR", comment: ""));
                                } else if !(result?.isCancelled)! {
                                    NSLog("---LoginViewController success");
                                    //ログインが成功
                                    ViewShowAnimation.changeViewWithIdentiferFromHome(self, toVC: "toUserRegisterView")
                                }
                            }
                            
                            // 通知の監視
                            if(!Thread.isMainThread){
                                NSLog("---LoginViewController !NSThread.isMainThread()");
                                DispatchQueue.main.sync {
                                    NSLog("---LoginViewController dispatch_sync");
                                    closure()
                                }
                            } else {
                                NSLog("---LoginViewController dispatch_sync else");
                                // 恐らく実行されない
                                closure()
                            }
            })
        }
        
    }
    
}
