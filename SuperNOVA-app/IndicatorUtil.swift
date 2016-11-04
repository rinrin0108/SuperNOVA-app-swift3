//
//  IndicatorUtil.swift
//  SuperNOVA-app
//
//  Created by t-kurasawa on 2016/09/24.
//  Copyright © 2016年 SuperNOVA. All rights reserved.
//

import UIKit
private var key = 0
struct Indicator {
    
    
    
    static var myActivityIndicator: UIActivityIndicatorView!
    
    static func set(_ v:UIViewController){
        self.myActivityIndicator = UIActivityIndicatorView()
        self.myActivityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.myActivityIndicator.center = v.view.center
        self.myActivityIndicator.hidesWhenStopped = false
        self.myActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        self.myActivityIndicator.backgroundColor = UIColor.gray;
        self.myActivityIndicator.layer.masksToBounds = true
        self.myActivityIndicator.layer.cornerRadius = 5.0;
        self.myActivityIndicator.layer.opacity = 0.8;
        v.view.addSubview(self.myActivityIndicator);
        
        self.dismiss();
    }
    
    static func show(){
        myActivityIndicator.startAnimating();
        myActivityIndicator.isHidden = false;
    }
    static func dismiss(){
        myActivityIndicator.stopAnimating();
        myActivityIndicator.isHidden = true;
    }
    
    static func windowSet(){
        NSLog("IndicatorUtil windowSet");
        let window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Indicator", bundle: nil)
        window.rootViewController = storyboard.instantiateInitialViewController()! as UIViewController
        window.windowLevel = UIWindowLevelNormal + 5
        
        window.makeKeyAndVisible()
        objc_setAssociatedObject(UIApplication.shared, &key, window, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    static func windowClose(){
        
        if objc_getAssociatedObject(UIApplication.shared, &key) != nil {
            let window :UIWindow = objc_getAssociatedObject(UIApplication.shared, &key) as! UIWindow
            window.rootViewController?.view.removeFromSuperview()
            window.rootViewController = nil
            objc_setAssociatedObject(UIApplication.shared, &key, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            let nextWindow :UIWindow = ((UIApplication.shared.delegate?.window)!)!
            nextWindow.makeKeyAndVisible()
        }
    }
}
