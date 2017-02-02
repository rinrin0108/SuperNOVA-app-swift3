//
//  GetRequestStatusTest.swift
//  SuperNOVA-app
//
//  Created by 朝日田卓哉 on 2017/01/27.
//  Copyright © 2017年 SuperNOVA. All rights reserved.
//

import Quick
import Nimble
import Mockingjay
@testable import SuperNOVA_app
class GetRequestStatusTest: QuickSpec {
    
    override func spec() {
        
        let id :String = "aaaaa"
        
        describe("MergerAPI.getRequestStatus") {
            
            URLSessionConfiguration.mockingjaySwizzleDefaultSessionConfiguration()
            
            context("正常系 すべての送信パラメータが正常値", closure: {
                
                beforeEach {
                    let body = ["errorCode":200, "errorMessage":nil, "teacher":"aaaa", "status":"req"] as [String : Any?]
                    self.stub(http(.get, uri: "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod//getRequestStatus?_id=" + id), json(body))
                }
                
                it("teacherとstatusに値が含まれていること", closure: {
                    var teacher : String? = nil
                    var status : String? = nil
                    MergerAPI.getRequestStatus(id, sync: true, success: { (values) in
                        teacher = values["teacher"] as? String
                        status = values["status"] as? String
                    }, failed: { (id, message) in
                        
                    })
                    
                    expect(teacher).toEventually(equal("aaaa"))
                    expect(status).toEventually(equal("req"))
                })
            })
            
            context("準正常系分岐 すべての送信パラメータが正常値", closure: {
                beforeEach {
                    let body = ["errorCode":503, "errorMessage":nil, "teacher":"aaaa", "status":"req"] as [String : Any?]
                    self.stub(http(.get, uri: "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod//getRequestStatus?_id=" + id), json(body))
                }
                
                it("errorCodeに値が入っている", closure: {
                    var teacher : String? = nil
                    var status : String? = nil
                    var errorCode :Int? = nil
                    var errorMessage :String? = nil
                    MergerAPI.getRequestStatus(id, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        
                    })
                    
                    expect(errorCode).toEventually(equal(503))
                    expect(errorMessage).toEventually(beNil())
                })
            })

            context("準正常系分岐 すべての送信パラメータが正常値", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":"error", "teacher":"aaaa", "status":"req"] as [String : Any?]
                    self.stub(http(.get, uri: "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod//getRequestStatus?_id=" + id), json(body))
                }
                
                it("errorMessageに値が入っている", closure: {
                    var teacher : String? = nil
                    var status : String? = nil
                    var errorCode :Int? = nil
                    var errorMessage :String? = nil
                    MergerAPI.getRequestStatus(id, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(equal("error"))
                })
            })
            
            context("nilチェック _idがnilの場合", closure: {
                beforeEach {
//                    let body = ["errorCode":nil, "errorMessage":"error", "teacher":"aaaa", "status":"req"] as [String : Any?]
//                    self.stub(http(.get, uri: "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod//getRequestStatus?_id=" + nil), json(body))
                }
                
                it("errorMessageに値が入っている", closure: {
                    var teacher : String? = nil
                    var status : String? = nil
                    var errorCode :Int? = nil
                    var errorMessage :String? = nil
                    MergerAPI.getRequestStatus(nil, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        teacher = values["teacher"] as? String
                        status = values["status"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    //結果が不明
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(equal("error"))
                })
            })
            
            context("nilチェック teacherがnilの場合", closure: {
                beforeEach {
                    let body = ["errorCode":200, "errorMessage":nil, "teacher":nil, "status":"req"] as [String : Any?]
                    self.stub(http(.get, uri: "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod//getRequestStatus?_id=" + id), json(body))
                }
                
                it("通信は成功する", closure: {
                    var teacher : String? = nil
                    var status : String? = nil
                    var errorCode :Int? = nil
                    var errorMessage :String? = nil
                    MergerAPI.getRequestStatus(nil, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        teacher = values["teacher"] as? String
                        status = values["status"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    //結果が不明
                    expect(errorCode).toEventually(equal(200))
                    expect(errorMessage).toEventually(beNil())
                    expect(teacher).toEventually(beNil())
                    expect(status).toEventually(equal("req"))
                })
            })
            
            context("nilチェック statusがnilの場合", closure: {
                beforeEach {
                    let body = ["errorCode":200, "errorMessage":nil, "teacher":"aaaa", "status":nil] as [String : Any?]
                    self.stub(http(.get, uri: "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod//getRequestStatus?_id=" + id), json(body))
                }
                
                it("通信は成功する", closure: {
                    var teacher : String? = nil
                    var status : String? = nil
                    var errorCode :Int? = nil
                    var errorMessage :String? = nil
                    MergerAPI.getRequestStatus(nil, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        teacher = values["teacher"] as? String
                        status = values["status"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    //結果が不明
                    expect(errorCode).toEventually(equal(200))
                    expect(errorMessage).toEventually(beNil())
                    expect(teacher).toEventually(equal("aaaa"))
                    expect(status).toEventually(beNil())
                })
            })
            
            context("nilチェック 受信パラメータが全てnilの場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "teacher":nil, "status":nil] as [String : Any?]
                    self.stub(http(.get, uri: "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod//getRequestStatus?_id=" + id), json(body))
                }
                
                it("通信は成功する", closure: {
                    var teacher : String? = nil
                    var status : String? = nil
                    var errorCode :Int? = nil
                    var errorMessage :String? = nil
                    MergerAPI.getRequestStatus(nil, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        teacher = values["teacher"] as? String
                        status = values["status"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    //結果が不明
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(teacher).toEventually(beNil())
                    expect(status).toEventually(beNil())
                })
            })
            
            context("空文字チェック _idが空文字の場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":"error", "teacher":"aaaa", "status":"req"] as [String : Any?]
                    self.stub(http(.get, uri: "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod//getRequestStatus?_id=" + ""), json(body))
                }
                
                it("errorMessageに値が入っている", closure: {
                    var teacher = ""
                    var status = ""
                    var errorCode :Int? = nil
                    var errorMessage :String? = nil
                    MergerAPI.getRequestStatus("", sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        teacher = values["teacher"] as! String
                        status = values["status"] as! String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    //結果が不明
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(equal("error"))
                })
            })
            
            context("空文字チェック teacherが空文字の場合", closure: {
                beforeEach {
                    let body = ["errorCode":200, "errorMessage":nil, "teacher":"", "status":"req"] as [String : Any?]
                    self.stub(http(.get, uri: "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod//getRequestStatus?_id=" + id), json(body))
                }
                
                it("通信は成功する", closure: {
                    var teacher : String? = nil
                    var status : String? = nil
                    var errorCode :Int? = nil
                    var errorMessage :String? = nil
                    MergerAPI.getRequestStatus(nil, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        teacher = values["teacher"] as? String
                        status = values["status"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    //結果が不明
                    expect(errorCode).toEventually(equal(200))
                    expect(errorMessage).toEventually(beNil())
                    expect(teacher).toEventually(equal(""))
                    expect(status).toEventually(equal("req"))
                })
            })
            
            context("空文字チェック statusが空文字の場合", closure: {
                beforeEach {
                    let body = ["errorCode":200, "errorMessage":nil, "teacher":"aaaa", "status":""] as [String : Any?]
                    self.stub(http(.get, uri: "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod//getRequestStatus?_id=" + id), json(body))
                }
                
                it("通信は成功する", closure: {
                    var teacher : String? = nil
                    var status : String? = nil
                    var errorCode :Int? = nil
                    var errorMessage :String? = nil
                    MergerAPI.getRequestStatus(nil, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        teacher = values["teacher"] as? String
                        status = values["status"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    //結果が不明
                    expect(errorCode).toEventually(equal(200))
                    expect(errorMessage).toEventually(beNil())
                    expect(teacher).toEventually(equal("aaaa"))
                    expect(status).toEventually(equal(""))
                })
            })
            
            context("空文字チェック 受信パラメータが全て空文字の場合", closure: {
                beforeEach {
                    let body = ["errorCode":"", "errorMessage":"", "teacher":"", "status":""] as [String : Any?]
                    self.stub(http(.get, uri: "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod//getRequestStatus?_id=" + id), json(body))
                }
                
                it("通信は成功する", closure: {
                    var teacher : String? = nil
                    var status : String? = nil
                    var errorCode :Int? = nil
                    var errorMessage :String? = nil
                    MergerAPI.getRequestStatus(nil, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        teacher = values["teacher"] as? String
                        status = values["status"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    //結果が不明
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(equal(""))
                    expect(teacher).toEventually(equal(""))
                    expect(status).toEventually(equal(""))
                })
            })
        }
    }
    
}
