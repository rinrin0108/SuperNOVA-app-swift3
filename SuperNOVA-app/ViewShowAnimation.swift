//
//  ViewShowAnimation.swift
//  Terrace
//
//  Created by 朝日田 卓哉 on 2016/06/24.
//  Copyright © 2016年 山口 竜也. All rights reserved.
//

import UIKit
import QuartzCore

class  ViewShowAnimation :NSObject{
    
    
    static func showAnimation(_ vc :UIViewController){
        
        let rect = vc.view.frame;
        for subview in vc.view.subviews{
            subview.frame = CGRect(x: subview.frame.origin.x, y: subview.frame.origin.y - rect.height, width: subview.frame.width, height: subview.frame.height);
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            for subview in vc.view.subviews{
                subview.frame = CGRect(x: subview.frame.origin.x, y: subview.frame.origin.y + rect.height, width: subview.frame.width, height: subview.frame.height);
            }
        }) { (Bool) -> Void in
            
        }
    }
    
    //要素にブラーをかけるタイプ
    func changeAnimation(_ fromVC :UIViewController, toVC :UIViewController){
        
        for subview in fromVC.view.subviews{
            subview.layer.shouldRasterize = true;
            subview.layer.rasterizationScale = 1.0;
            subview.layer.minificationFilter = kCAFilterTrilinear;
        }
        
        let animation = CABasicAnimation(keyPath: "rasterizationScale");
        animation.fromValue = 1.0;
        animation.toValue = 0.01;
        animation.duration = 0.3;
        animation.isRemovedOnCompletion = false;
        animation.fillMode = kCAFillModeForwards;
        
        let alphaAnimation = CABasicAnimation(keyPath: "opacity");
        alphaAnimation.fromValue = 1.0;
        alphaAnimation.toValue = 0.0;
        alphaAnimation.duration = 0.3;
        alphaAnimation.isRemovedOnCompletion = false;
        
        for subview in fromVC.view.subviews{
            subview.layer.add(animation, forKey: "rasterizationScale");
            subview.layer.add(alphaAnimation, forKey: "opacity");
            subview.layer.minificationFilter = kCAFilterTrilinear;
        }
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 1)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
            fromVC.present(toVC, animated: true, completion: nil)
        })
    }
    
    //全体にブラーをかけるタイプ
    static func changeView(_ fromVC :UIViewController, toVC :UIViewController){
        let blurEffect: UIVisualEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight);
        let blurView :UIVisualEffectView = UIVisualEffectView(effect: blurEffect);
        blurView.frame = fromVC.view.frame;
        fromVC.view.addSubview(blurView);
        
        blurView.alpha = 0.0;
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            for subview in fromVC.view.subviews {
                subview.alpha = 0.0;
            }
            blurView.alpha = 0.3;
        }) { (Bool) -> Void in
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
                blurView.alpha = 0.0;
            }) { (Bool) -> Void in
                fromVC.present(toVC, animated: false, completion: nil)
                //                        for subview in fromVC.view.subviews {
                //                            subview.alpha = 1.0;
                //                        }
                //                        blurView.removeFromSuperview();
            }
        }
    }
    
    static func changeViewWithIdentifer(_ fromVC :UIViewController, toVC :String){
        let blurEffect: UIVisualEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight);
        let blurView :UIVisualEffectView = UIVisualEffectView(effect: blurEffect);
        blurView.frame = fromVC.view.frame;
        fromVC.view.addSubview(blurView);
        
        blurView.alpha = 0.0;
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            for subview in fromVC.view.subviews {
                subview.alpha = 0.0;
            }
            blurView.alpha = 0.3;
        }) { (Bool) -> Void in
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
                blurView.alpha = 0.0;
            }) { (Bool) -> Void in
                fromVC.performSegue(withIdentifier: toVC,sender: nil)
                for subview in fromVC.view.subviews {
                    subview.alpha = 1.0;
                }
                blurView.removeFromSuperview();
            }
        }
    }
    
    static func changeViewWithIdentiferNotRemove(_ fromVC :UIViewController, toVC :String){
        let blurEffect: UIVisualEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight);
        let blurView :UIVisualEffectView = UIVisualEffectView(effect: blurEffect);
        blurView.frame = fromVC.view.frame;
        fromVC.view.addSubview(blurView);
        
        blurView.alpha = 0.0;
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            for subview in fromVC.view.subviews {
                subview.alpha = 0.0;
            }
            blurView.alpha = 0.3;
        }) { (Bool) -> Void in
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
                blurView.alpha = 0.0;
            }) { (Bool) -> Void in
                fromVC.performSegue(withIdentifier: toVC,sender: nil)
                //                        for subview in fromVC.view.subviews {
                //                            subview.alpha = 1.0;
                //                        }
                blurView.removeFromSuperview();
            }
        }
    }
    
    static func changeViewWithIdentiferFromHome(_ homeView:UIViewController, toVC:String){
        let blurEffect: UIVisualEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight);
        let blurView :UIVisualEffectView = UIVisualEffectView(effect: blurEffect);
        blurView.frame = homeView.view.frame;
        homeView.view.addSubview(blurView);
        
        blurView.alpha = 0.0;
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            for subview in homeView.view.subviews {
                subview.alpha = 0.0;
            }
            blurView.alpha = 0.3;
        }) { (Bool) -> Void in
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
                blurView.alpha = 0.0;
            }) { (Bool) -> Void in
                UIView.setAnimationsEnabled(false)
                homeView.performSegue(withIdentifier: toVC,sender: nil)
                UIView.setAnimationsEnabled(true)
                for subview in homeView.view.subviews {
                    subview.alpha = 1.0;
                }
                homeView.view.frame = CGRect(x: 0, y: -homeView.view.frame.height, width: homeView.view.frame.width, height: homeView.view.frame.height);
                blurView.removeFromSuperview();
            }
        }
    }
    
    static func returnView(_ vc: UIViewController, navi :UINavigationController){
        let blurEffect: UIVisualEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight);
        let blurView :UIVisualEffectView = UIVisualEffectView(effect: blurEffect);
        blurView.frame = vc.view.frame;
        vc.view.addSubview(blurView);
        
        blurView.alpha = 0.0;
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            for subview in vc.view.subviews {
                subview.alpha = 0.0;
            }
            blurView.alpha = 0.3;
        }) { (Bool) -> Void in
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
                blurView.alpha = 0.0;
            }) { (Bool) -> Void in
                navi.popViewController(animated: false);
            }
        }
    }
    
    static func returnViewModal(_ vc :UIViewController){
        let blurEffect: UIVisualEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight);
        let blurView :UIVisualEffectView = UIVisualEffectView(effect: blurEffect);
        blurView.frame = vc.view.frame;
        vc.view.addSubview(blurView);
        
        blurView.alpha = 0.0;
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            for subview in vc.view.subviews {
                subview.alpha = 0.0;
            }
            blurView.alpha = 0.3;
        }) { (Bool) -> Void in
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
                blurView.alpha = 0.0;
            }) { (Bool) -> Void in
                vc.dismiss(animated: false, completion: nil)
            }
        }
    }
}
