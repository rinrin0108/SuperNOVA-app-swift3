//
//  ResponseTeacherTest.swift
//  SuperNOVA-app
//
//  Created by 朝日田卓哉 on 2017/01/26.
//  Copyright © 2017年 SuperNOVA. All rights reserved.
//

import Quick
import Nimble
import Mockingjay
@testable import SuperNOVA_app

class ResponseTeacherTest: QuickSpec {
    
    var statusCode : Int?
    var errorMessage :String?
    // 正常系　新規
    
    var userID :String = "123456"
    var id :String = "098765"

    override func spec() {
        
        URLSessionConfiguration.mockingjaySwizzleDefaultSessionConfiguration()
        
        describe("ResponseTeacher API(テスト名)"){
            context("送信パラメータが正常値のときerrorCodeとerrorMessageがnilであること"){
                beforeEach {
                    //setup stub
                    let body = ["errorCode":nil, "errorMessage":nil] as [String : Any?]
                    self.stub(http(.get, uri: "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod/responseTeacher?_id=" + self.id + "&userid=" + self.userID), json(body))
                }
                
                it("nilが入力される"){
                    MergerAPI.responseTeacher(self.userID, _id: self.id, sync: true, success: { (values) in
                        self.statusCode = values["errorCode"] as! Int?
                        self.errorMessage = values["errorMessage"] as! String?
                        
                    }, failed: { (id, message) in
                        
                    })
                    expect(self.statusCode).toEventually(equal(nil))
                    expect(self.errorMessage).toEventually(equal(nil))
                }
            }
            
            context("すべての送信パラメータが正常値であり、errorCodeに値が入っている", closure: {
                beforeEach {
                    //setup stub
                    let body = ["errorCode":200, "errorMessage":nil] as [String : Any?]
                    self.stub(http(.get, uri: "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod/responseTeacher?_id=" + self.id + "&userid=" + self.userID), json(body))
                }
                
                it("メソッドが実行される", closure: {
                    MergerAPI.responseTeacher(self.userID, _id: self.id, sync: true, success: { (values) in
                        self.statusCode = values["errorCode"] as! Int?
                        self.errorMessage = values["errorMessage"] as! String?
                        
                    }, failed: { (id, message) in
                        
                    })
                    expect(self.statusCode).toEventually(equal(200))
                    expect(self.errorMessage).toEventually(equal(nil))
                })
            })
            
            context("すべての送信パラメータが正常値であり、errorMessageに値が入っている", closure: {
                beforeEach {
                    //setup stub
                    let body = ["errorCode":nil, "errorMessage":"aaaa"] as [String : Any?]
                    self.stub(http(.get, uri: "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod/responseTeacher?_id=" + self.id + "&userid=" + self.userID), json(body))
                }
                
                it("メソッドが実行される", closure: {
                    MergerAPI.responseTeacher(self.userID, _id: self.id, sync: true, success: { (values) in
                        self.statusCode = values["errorCode"] as! Int?
                        self.errorMessage = values["errorMessage"] as! String?
                        
                    }, failed: { (id, message) in
                        
                    })
                    expect(self.statusCode).toEventually(equal(nil))
                    expect(self.errorMessage).toEventually(equal("aaaa"))
                })
            })
            
            context("useridがnilの場合", closure: {
                beforeEach {
                    //setup stub
                }
                
                it("通信が失敗し、エラーコードとメッセージが返される", closure: {
                    MergerAPI.responseTeacher(nil, _id: self.id, sync: true, success: { (values) in
                    }, failed: { (id, message) in
                        self.statusCode = id
                        self.errorMessage = message
                    })
                    expect(self.statusCode).toNotEventually(equal(nil))
                    expect(self.errorMessage).toNotEventually(equal(nil))
                })
            })
            
            context("_idがnilの場合", closure: {
                beforeEach {
                    //setup stub
                }
                
                it("通信が失敗し、エラーコードとメッセージが返される", closure: {
                    MergerAPI.responseTeacher(self.userID, _id: nil, sync: true, success: { (values) in
                    }, failed: { (id, message) in
                        self.statusCode = id
                        self.errorMessage = message
                    })
                    expect(self.statusCode).toNotEventually(equal(nil))
                    expect(self.errorMessage).toNotEventually(equal(nil))
                })
            })
            
            context("useridが空文字の場合", closure: {
                beforeEach {
                    //setup stub
                }
                
                it("通信が失敗し、エラーコードとメッセージが返される", closure: {
                    MergerAPI.responseTeacher("", _id: self.id, sync: true, success: { (values) in
                    }, failed: { (id, message) in
                        self.statusCode = id
                        self.errorMessage = message
                    })
                    expect(self.statusCode).toNotEventually(equal(nil))
                    expect(self.errorMessage).toNotEventually(equal(nil))
                })
            })
            
            context("_idが空文字の場合", closure: {
                beforeEach {
                    //setup stub
                }
                
                it("通信が失敗し、エラーコードとメッセージが返される", closure: {
                    MergerAPI.responseTeacher(self.userID, _id: "", sync: true, success: { (values) in
                    }, failed: { (id, message) in
                        self.statusCode = id
                        self.errorMessage = message
                    })
                    expect(self.statusCode).toNotEventually(equal(nil))
                    expect(self.errorMessage).toNotEventually(equal(nil))
                })
            })
        }
    }
    
}
