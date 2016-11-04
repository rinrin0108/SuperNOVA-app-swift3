//
//  AccountInfo.swift
//  SuperNOVA-app
//
//  Created by t-kurasawa on 2016/09/24.
//  Copyright © 2016年 SuperNOVA. All rights reserved.
//

import Foundation


/// アカウント情報クラス<br>
/// アカウントの情報をアプリケーション内で共通で使用する為のクラス<br>
///
final class AccountInfo {
    
    fileprivate let store               : UserDefaults    = UserDefaults.standard
    ///キー一覧
    /// メールアドレス
    fileprivate let mailAddressKey      : String!           = "userid"
    /// プロフィール画像
    fileprivate let imageKey            : String!           = "image"

    /// Full Name
    fileprivate let fullnameKey      : String!           = "fullname"
    
    
    /// メールアドレス
    fileprivate var mailAddressValue : String!
    
    /// プロフィール画像URL
    fileprivate var imageValue : String!

    /// Full Name
    fileprivate var fullnameValue      : String!

    ///シングルトンインスタンス
    fileprivate static let info : AccountInfo = AccountInfo()
    static func get() -> AccountInfo{ return info }
    
    /// コンストラクタ
    /// 該当機能ではインスタンスの生成を外部で行わない為、privateとする。
    fileprivate init(){
        
        NSLog("AccountInfo init");
        // キーがidの値をとります。
        let mailAddressValue    : String?   = store.string(forKey: mailAddressKey)
        NSLog(mailAddressValue!);
        let imageValue          : String?   = store.string(forKey: imageKey)
        NSLog(imageValue!);
        let fullnameValue    : String?   = store.string(forKey: fullnameKey)
        NSLog(fullnameValue!);
        
        //値の設定
        self.mailAddressValue   = mailAddressValue  != nil ? mailAddressValue : ""
        NSLog(self.mailAddress);
        self.imageValue         = imageValue
        NSLog(self.imageValue);
        self.fullnameValue   = fullnameValue
        NSLog(self.fullnameValue);
    }
    
    
    var mailAddress : String!{
        get {
            return mailAddressValue
        }
        set(mailAddressValue) {
            self.mailAddressValue = mailAddressValue
            store.set(mailAddressValue, forKey: mailAddressKey)
            store.synchronize()
        }
    }
    
    var image : String!{
        get {
            return imageValue
        }
        set(imageValue) {
            self.imageValue = imageValue
            store.set(imageValue, forKey: imageKey)
            store.synchronize()
        }
        
    }
    
    var fullname : String!{
        get {
            return fullnameValue
        }
        set(fullname) {
            self.fullnameValue = fullname
            store.set(fullnameValue, forKey: fullnameKey)
            store.synchronize()
        }
    }
    
}
