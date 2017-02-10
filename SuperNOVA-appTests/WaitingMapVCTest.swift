//
//  WaitingMapVCTest.swift
//  SuperNOVA-app
//
//  Created by 朝日田卓哉 on 2017/01/25.
//  Copyright © 2017年 SuperNOVA. All rights reserved.
//

import Quick
import Nimble
import Mockingjay
@testable import SuperNOVA_app

class WaitingMapVCTest: QuickSpec {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var mainVC :WaitingMapViewController!
    
    let requestTeacherURI = "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod//requestTeacher"
    let getRequestStatusURI = "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod//getRequestStatus?.*"
    
    override func spec() {
        URLSessionConfiguration.mockingjaySwizzleDefaultSessionConfiguration()
        beforeSuite {
            var _:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            //appDelegateが呼ばれてないのでoptionalエラーでおちる？
            self.mainVC = self.storyboard.instantiateViewController(withIdentifier: "WaitingMapViewController") as! WaitingMapViewController
            UIApplication.shared.keyWindow?.rootViewController = self.mainVC
            self.mainVC.performSelector(onMainThread: #selector(self.mainVC.viewDidAppear(_:)), with: nil, waitUntilDone: true)
            
        }
        
        
        

            describe("WaitingMapVCTest"){
                /*
                context("appDelegateがnilの場合"){
                    beforeEach {
                        UIApplication.shared.delegate = nil
                        let _ =  self.mainVC.view
                    }
                    it("メソッドが実行される"){
                        let btn = UIButton()
                        expect(self.mainVC.waiting(btn)).to(beNil())
                    }
                }
 */
                /*
                context("shopImageがnilの場合"){
                    beforeEach {
                        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate._shopimage = nil
                        let _ =  self.mainVC.view
                    }
                    it("メソッドが実行される"){
                        let btn = UIButton()
                        expect(self.mainVC.waiting(btn)).to(beNil())
                    }
                }
 */
            }
            
            describe("MergerAPI.requestTeacher"){
                /*
                context("通信が成功し、受信パラメータが全てnilの場合", closure: {
                    beforeEach {
                        let body = ["errorCode":nil, "errorMessage":nil, "_id":nil] as [String : Any?]
                        MockingjayProtocol.addStub(http(.post, uri: "/requestTeacher"), json(body))
                        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        
                        appDelegate._userid = "0000"
                        appDelegate._lat = "35.698353"
                        appDelegate._lng = "139.773114"
                        appDelegate._lang = "English"
                        appDelegate._place = "SHOP01"
                        appDelegate._time = 30
                        appDelegate._shopimage = "https://s3-ap-northeast-1.amazonaws.com/supernova-hack/noimage.png"
                 
                 appDelegate._id = "aaaa"
                 let body2 = ["errorCode":200, "errorMessage":"aaa", "teacher":"aaaa", "status":"aaaa"] as [String : Any?]
                 MockingjayProtocol.addStub(matcher: http(.get, uri: "https://s3-ap-northeast-1.amazonaws.com/supernova-hack/getRequestStatus?_id=aaaa"), builder: json(body2))
                    }
                    
                    it("メソッドが実行される", closure: {
                        let btn = UIButton()
                        expect(self.mainVC.waiting(btn)).to(beNil())
                    })
                })
 */
                
                context("通信が成功し、errorCodeとerrorMessageがnilで_idに値が入っている場合", closure: {
                    beforeEach {
                        let body = ["errorCode":200, "errorMessage":"aaa", "_id":"bbbb"] as [String : Any?]
                        MockingjayProtocol.addStub(matcher: http(.post, uri: self.requestTeacherURI), builder: json(body))
                        
                        
                        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        
                        appDelegate._userid = "0000"
                        appDelegate._lat = "35.698353"
                        appDelegate._lng = "139.773114"
                        appDelegate._lang = "English"
                        appDelegate._place = "SHOP01"
                        appDelegate._time = 30
                        appDelegate._shopimage = "https://s3-ap-northeast-1.amazonaws.com/supernova-hack/noimage.png"
                        
                        appDelegate._id = "aaaa"
                        appDelegate._shoplat = 35.698353
                        appDelegate._shoplng = 139.773114
                        let body2 = ["errorCode":200, "errorMessage":"aaa", "teacher":"aaaa", "status":"aaaa"] as [String : Any?]
                        MockingjayProtocol.addStub(matcher: http(.get, uri: self.getRequestStatusURI), builder: json(body2))
                    }
                    
                    it("メソッドが実行される", closure: {
                        let btn = UIButton()
                        self.mainVC.waiting(btn)
                        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        expect(appDelegate._id).toEventually(equal("bbbb"))
//                        expect(UIApplication.shared.keyWindow?.rootViewController).toEventually(beAKindOf(EvaluateViewController.self))
                    })
                })
            }
    }
}
