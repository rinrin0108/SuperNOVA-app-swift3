//
//  UserRegisterViewController.swift
//  SuperNOVA-app
//
//  Created by t-kurasawa on 2016/09/24.
//  Copyright © 2016年 SuperNOVA. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class UserRegisterViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var first_name: UILabel!
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var last_name: UILabel!
    fileprivate var profileImageURL :String!
    fileprivate var selectImage: UIImage?
    fileprivate var isLoaded :Bool = false
    
    @IBOutlet weak var japaneseBtn: UIButton!
    @IBOutlet weak var englishBtn: UIButton!
    
    @IBAction func changeJapanese(_ sender: UIButton) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        appDelegate._lang = "Japanese"
        appDelegate._native = "English"
        
        //registUserBtn.isUserInteractionEnabled = true
        japaneseBtn.setBackgroundImage(UIImage(named: "btn_orange"), for: UIControlState.normal)
        englishBtn.setBackgroundImage(UIImage(named: "btn_gray"), for: UIControlState.normal)
        
    }

    @IBAction func changeEnglish(_ sender: UIButton) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        appDelegate._lang = "English"
        appDelegate._native = "Japanese"
        
        //registUserBtn.isUserInteractionEnabled = true
        japaneseBtn.setBackgroundImage(UIImage(named: "btn_gray"), for: UIControlState.normal)
        englishBtn.setBackgroundImage(UIImage(named: "btn_orange"), for: UIControlState.normal)
    }
    
    
    @IBAction func registUser(_ sender: UIButton) {
        NSLog("---UserRegisterViewController registUser");
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        if(appDelegate._lang == ""){
            appDelegate._lang      = "English";
            appDelegate._native      = "Japanese";
        }
        
        // ユーザ登録API呼び出し
        UserAPI.registUser(email.text, first_name: first_name.text, last_name: last_name.text , lang: appDelegate._lang , native: appDelegate._native, profileImageURL: profileImageURL ,sync: true,
                        success:{
                        values in let closure = {
                            NSLog("---UserRegisterViewController UserAPI.registUser success");
                            // 通信は成功したが、エラーが返ってきた場合
                            if(API.isError(values)){
                                NSLog("---UserRegisterViewController UserAPI.registUser isError");
                                /**
                                 * ストーリーボードをまたぐ時に値を渡すためのもの（Indicatorストーリーボードを作成する必要あり）
                                Indicator.windowClose()
                                */
                                AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),
                                    message: values["errorMessage"] as! String)
                                return
                            }
                            
                            // API返却値と、画面入力値を端末に保存
                            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
                            appDelegate._userid    = self.email.text
                            appDelegate._image     = self.profileImageURL
                            appDelegate._fullname  = self.first_name.text! + self.last_name.text!
                            //FIXME
                            if(appDelegate._lang == ""){
                                appDelegate._lang      = "Japanese";
                                appDelegate._native      = "English";
                            }
                            
                            //ユーザー情報をアプリに登録（NSUserDefaults永続化）
                            self.registLoginData();
                            
                            // MapViewに画面遷移
                            ViewShowAnimation.changeViewWithIdentiferFromHome(self, toVC: "toMapView")
                        }
                        // 通知の監視
                        if(!Thread.isMainThread){
                            NSLog("---UserRegisterViewController !NSThread.isMainThread() in success");
                            DispatchQueue.main.sync {
                                NSLog("---UserRegisterViewController dispatch_sync");
                                closure()
                            }
                        } else {
                            NSLog("---UserRegisterViewController dispatch_sync else");
                            // 恐らく実行されない
                            closure()
                        }
                        
            },
                       failed: {
                        id, message in let closure = {
                            NSLog("---UserRegisterViewController UserAPI.registUser failed");
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
                            NSLog("---UserRegisterViewController !NSThread.isMainThread() in failed");
                            DispatchQueue.main.sync {
                                NSLog("---UserRegisterViewController dispatch_sync");
                                closure()
                            }
                        } else {
                            NSLog("---UserRegisterViewController dispatch_sync else");
                            //恐らく実行されない
                            closure()
                        }
            }
        )
        
    }
    
    //ユーザー情報をアプリに登録（NSUserDefaults永続化）
    func registLoginData()->Bool {
        NSLog("---UserRegisterViewController registLoginData")
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        let user = [
            "userid": appDelegate._userid,
            "image":appDelegate._image,
            "fullname":appDelegate._fullname,
            ]
        
        let defaults = UserDefaults.standard
        defaults.set(user, forKey: "User")
        
        if defaults.synchronize() {
            NSLog("---UserRegisterViewController registUserInApp success")
            return true;
        } else {
            NSLog("---UserRegisterViewController registUserInApp failed")
            return false;
        }
    }
    
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        NSLog("---UserRegisterViewController viewDidLoad");
                //Facebookがログイン済みの場合その情報を反映させる。
                if (FBSDKAccessToken.current() != nil) {
                    NSLog("---UserRegisterViewController FBSDKAccessToken.currentAccessToken()");
                    let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me",
                        parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"])
                    graphRequest.start(completionHandler: {
                        connection, result, error in
        
                        if error != nil
                        {
                            // エラー処理
                            NSLog("Error: \(error)")
                        }
                        else
                        {
                            NSLog("---UserRegisterViewController graphRequest.startWithCompletionHandler success");
                            // プロフィール情報をディクショナリに入れる
                            let userProfile : NSDictionary! = result as! NSDictionary
        
                            // プロフィール画像の取得
                            let profileImageURL : String = ((userProfile.object(forKey: "picture") as AnyObject).object(forKey: "data") as AnyObject).object(forKey: "url") as! String
                            
                            NSLog((userProfile.object(forKey: "id") as? String)!);
                            NSLog((userProfile.object(forKey: "name") as? String)!);
                            NSLog((userProfile.object(forKey: "first_name") as? String)!);
                            NSLog((userProfile.object(forKey: "last_name") as? String)!);
                            NSLog(profileImageURL);
                            NSLog((userProfile.object(forKey: "email") as? String)!);
        
                            if profileImageURL != "" {
                                NSLog("---UserRegisterViewController profileImageURL is not null");
                                let profileImage : UIImage? = API.downloadImage(profileImageURL)
                                self.profile.image = profileImage
                                self.selectImage = profileImage
                                self.profile.layer.cornerRadius = self.profile.frame.size.width / 2
                                self.profile.clipsToBounds = true
                            }
        
                            //ユーザID,メールアドレス,氏,名を設定
                            self.first_name.text = userProfile.object(forKey: "first_name") as? String
                            NSLog("self.first_name.text!");
                            NSLog(self.first_name.text!);
                            self.last_name.text = userProfile.object(forKey: "last_name") as? String
                            NSLog("self.last_name.text!");
                            NSLog(self.last_name.text!);
                            self.email.text  = userProfile.object(forKey: "email") as? String
                            NSLog("self.email.text!");
                            NSLog(self.email.text!);
                            self.profileImageURL = profileImageURL
                            NSLog("self.profileImageURL");
                            NSLog(self.profileImageURL);
                        }
                    })
                }
        NSLog("isLoaded");
        isLoaded = true
        
        //registUserBtn.isUserInteractionEnabled = false
    }
    
    @IBOutlet weak var registUserBtn: UIButton!
    
    fileprivate func encode(_ url:String) -> (String){
        return url.replacingOccurrences(of: "&", with: "%%%");
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isLoaded{
            for subview in self.view.subviews{
                subview.isHidden = false
            }
//            ViewShowAnimation.showAnimation(self);
            isLoaded = false
        }
    }
    
}
