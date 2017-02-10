//
//  SearchRequestTest.swift
//  SuperNOVA-app
//
//  Created by 朝日田卓哉 on 2017/02/08.
//  Copyright © 2017年 SuperNOVA. All rights reserved.
//

import Quick
import Nimble
import Mockingjay
@testable import SuperNOVA_app

class SearchRequestTest: QuickSpec {
    
    let userid = "asahida.test@gmail.com"
    let lat = "35.698353"
    let lng = "139.773114"
    let lang = "Japanese"
    
    let uri = "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod//searchRequest?.*"
    
    override func spec() {
        describe("MergerAPI.searchRequest") {
            context("すべての送信パラメータが正常値", closure: {
                beforeEach {
                    //                    let body = ["errorCode":nil, "errorMessage":nil, "status":nil, "location":nil, "place":nil, "placeimg":nil, "time":nil, "_id":nil, "student":nil ] as [String : Any?]
                    //                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                it("errorCodeとerrorMessageがnilであり、その他に値が含まれていること", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            context("すべての送信パラメータが正常値", closure: {
                beforeEach {
                    let body = ["errorCode":503, "errorMessage":nil, "status":"aaa", "location":"aaaa", "place":"aaa", "placeimg":"aaa", "time":0, "_id":"aaa", "student":"aaa" ] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                it("errorCodeに値が入っている", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("すべての送信パラメータが正常値", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":"error", "status":"aaa", "location":"aaaa", "place":"aaa", "placeimg":"aaa", "time":0, "_id":"aaa", "student":"aaa" ] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                it("errorMessageに値が入っている", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
        }
        //########################################################################################
        //########################################################################################
        describe("nilチェック") {
//            context("送信パラメータが全てnilの場合", closure: {
//                beforeEach {
////                    let body = ["errorCode":nil, "errorMessage":nil, "status":nil, "location":nil, "place":nil, "placeimg":nil, "time":nil, "_id":nil, "student":nil ] as [String : Any?]
////                    self.stub(http(.get, uri: self.uri), json(body))
//                }
//                
//                //結果不明
//                it("通信が失敗する？", closure: {
//                    
//                    var errorCode :Int?
//                    var errorMessage :String?
//                    var status: String?
//                    var location:NSArray?
//                    var place:String?
//                    var placeimg:String?
//                    var time:Int?
//                    var _id:String?
//                    var student:String?
//                    
//                    MergerAPI.searchRequest(nil, lng: nil, lang: nil, userid: nil, sync: true, success: { (values) in
//                        errorCode = values["errorCode"] as? Int
//                        errorMessage = values["errorMessage"] as? String
//                        status = values["status"] as? String
//                        location = values["location"] as? NSArray
//                        place = values["place"] as? String
//                        placeimg = values["placeimg"] as? String
//                        time = values["time"] as? Int
//                        _id = values["_id"] as? String
//                        student = values["student"] as? String
//                    }, failed: { (id, message) in
//                        errorCode = id
//                        errorMessage = message
//                    })
//                    
//                    expect(errorCode).toNotEventually(beNil())
//                    expect(errorMessage).toNotEventually(beNil())
//                    expect(status).toEventually(beNil())
//                    expect(location).toEventually(beNil())
//                    expect(place).toEventually(beNil())
//                    expect(placeimg).toEventually(beNil())
//                    expect(time).toEventually(beNil())
//                    expect(_id).toEventually(beNil())
//                    expect(student).toEventually(beNil())
//                })
//            })
//            
//            context("latがnilの場合", closure: {
//                beforeEach {
//                    //                    let body = ["errorCode":nil, "errorMessage":nil, "status":nil, "location":nil, "place":nil, "placeimg":nil, "time":nil, "_id":nil, "student":nil ] as [String : Any?]
//                    //                    self.stub(http(.get, uri: self.uri), json(body))
//                }
//                
//                //結果不明
//                it("通信が失敗する？", closure: {
//                    
//                    var errorCode :Int?
//                    var errorMessage :String?
//                    var status: String?
//                    var location:NSArray?
//                    var place:String?
//                    var placeimg:String?
//                    var time:Int?
//                    var _id:String?
//                    var student:String?
//                    
//                    MergerAPI.searchRequest(nil, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
//                        errorCode = values["errorCode"] as? Int
//                        errorMessage = values["errorMessage"] as? String
//                        status = values["status"] as? String
//                        location = values["location"] as? NSArray
//                        place = values["place"] as? String
//                        placeimg = values["placeimg"] as? String
//                        time = values["time"] as? Int
//                        _id = values["_id"] as? String
//                        student = values["student"] as? String
//                    }, failed: { (id, message) in
//                        errorCode = id
//                        errorMessage = message
//                    })
//                    
//                    expect(errorCode).toNotEventually(beNil())
//                    expect(errorMessage).toNotEventually(beNil())
//                    expect(status).toEventually(beNil())
//                    expect(location).toEventually(beNil())
//                    expect(place).toEventually(beNil())
//                    expect(placeimg).toEventually(beNil())
//                    expect(time).toEventually(beNil())
//                    expect(_id).toEventually(beNil())
//                    expect(student).toEventually(beNil())
//                })
//            })
//            
//            context("lngがnilの場合", closure: {
//                beforeEach {
//                    //                    let body = ["errorCode":nil, "errorMessage":nil, "status":nil, "location":nil, "place":nil, "placeimg":nil, "time":nil, "_id":nil, "student":nil ] as [String : Any?]
//                    //                    self.stub(http(.get, uri: self.uri), json(body))
//                }
//                
//                //結果不明
//                it("通信が失敗する？", closure: {
//                    
//                    var errorCode :Int?
//                    var errorMessage :String?
//                    var status: String?
//                    var location:NSArray?
//                    var place:String?
//                    var placeimg:String?
//                    var time:Int?
//                    var _id:String?
//                    var student:String?
//                    
//                    MergerAPI.searchRequest(self.lat, lng: nil, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
//                        errorCode = values["errorCode"] as? Int
//                        errorMessage = values["errorMessage"] as? String
//                        status = values["status"] as? String
//                        location = values["location"] as? NSArray
//                        place = values["place"] as? String
//                        placeimg = values["placeimg"] as? String
//                        time = values["time"] as? Int
//                        _id = values["_id"] as? String
//                        student = values["student"] as? String
//                    }, failed: { (id, message) in
//                        errorCode = id
//                        errorMessage = message
//                    })
//                    
//                    expect(errorCode).toNotEventually(beNil())
//                    expect(errorMessage).toNotEventually(beNil())
//                    expect(status).toEventually(beNil())
//                    expect(location).toEventually(beNil())
//                    expect(place).toEventually(beNil())
//                    expect(placeimg).toEventually(beNil())
//                    expect(time).toEventually(beNil())
//                    expect(_id).toEventually(beNil())
//                    expect(student).toEventually(beNil())
//                })
//            })
//            
//            context("langがnilの場合", closure: {
//                beforeEach {
//                    //                    let body = ["errorCode":nil, "errorMessage":nil, "status":nil, "location":nil, "place":nil, "placeimg":nil, "time":nil, "_id":nil, "student":nil ] as [String : Any?]
//                    //                    self.stub(http(.get, uri: self.uri), json(body))
//                }
//                
//                //結果不明
//                it("通信が失敗する？", closure: {
//                    
//                    var errorCode :Int?
//                    var errorMessage :String?
//                    var status: String?
//                    var location:NSArray?
//                    var place:String?
//                    var placeimg:String?
//                    var time:Int?
//                    var _id:String?
//                    var student:String?
//                    
//                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: nil, userid: self.userid, sync: true, success: { (values) in
//                        errorCode = values["errorCode"] as? Int
//                        errorMessage = values["errorMessage"] as? String
//                        status = values["status"] as? String
//                        location = values["location"] as? NSArray
//                        place = values["place"] as? String
//                        placeimg = values["placeimg"] as? String
//                        time = values["time"] as? Int
//                        _id = values["_id"] as? String
//                        student = values["student"] as? String
//                    }, failed: { (id, message) in
//                        errorCode = id
//                        errorMessage = message
//                    })
//                    
//                    expect(errorCode).toNotEventually(beNil())
//                    expect(errorMessage).toNotEventually(beNil())
//                    expect(status).toEventually(beNil())
//                    expect(location).toEventually(beNil())
//                    expect(place).toEventually(beNil())
//                    expect(placeimg).toEventually(beNil())
//                    expect(time).toEventually(beNil())
//                    expect(_id).toEventually(beNil())
//                    expect(student).toEventually(beNil())
//                })
//            })
//            
//            context("useridがnilの場合", closure: {
//                beforeEach {
//                    //                    let body = ["errorCode":nil, "errorMessage":nil, "status":nil, "location":nil, "place":nil, "placeimg":nil, "time":nil, "_id":nil, "student":nil ] as [String : Any?]
//                    //                    self.stub(http(.get, uri: self.uri), json(body))
//                }
//                
//                //結果不明
//                it("通信が失敗する？", closure: {
//                    
//                    var errorCode :Int?
//                    var errorMessage :String?
//                    var status: String?
//                    var location:NSArray?
//                    var place:String?
//                    var placeimg:String?
//                    var time:Int?
//                    var _id:String?
//                    var student:String?
//                    
//                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: nil, sync: true, success: { (values) in
//                        errorCode = values["errorCode"] as? Int
//                        errorMessage = values["errorMessage"] as? String
//                        status = values["status"] as? String
//                        location = values["location"] as? NSArray
//                        place = values["place"] as? String
//                        placeimg = values["placeimg"] as? String
//                        time = values["time"] as? Int
//                        _id = values["_id"] as? String
//                        student = values["student"] as? String
//                    }, failed: { (id, message) in
//                        errorCode = id
//                        errorMessage = message
//                    })
//                    
//                    expect(errorCode).toNotEventually(beNil())
//                    expect(errorMessage).toNotEventually(beNil())
//                    expect(status).toEventually(beNil())
//                    expect(location).toEventually(beNil())
//                    expect(place).toEventually(beNil())
//                    expect(placeimg).toEventually(beNil())
//                    expect(time).toEventually(beNil())
//                    expect(_id).toEventually(beNil())
//                    expect(student).toEventually(beNil())
//                })
//            })
        
            context("受信パラメータが全てnilの場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "status":nil, "location":nil, "place":nil, "placeimg":nil, "time":nil, "_id":nil, "student":nil ] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("メソッドが実行される", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toEventually(beNil())
                    expect(location).toEventually(beNil())
                    expect(place).toEventually(beNil())
                    expect(placeimg).toEventually(beNil())
                    expect(time).toEventually(beNil())
                    expect(_id).toEventually(beNil())
                    expect(student).toEventually(beNil())
                })
            })
            
            context("statusがnilの場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "status":nil, "location":"aaa", "place":"aaa", "placeimg":"aaa", "time":0, "_id":"aaa", "student":"aaa" ] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("メソッドが実行される", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("locationがnilの場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "status":"aaa", "location":nil, "place":"aaa", "placeimg":"aaa", "time":0, "_id":"aaa", "student":"aaa" ] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("メソッドが実行される", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("placeがnilの場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "status":"aaa", "location":"aaa", "place":nil, "placeimg":"aaa", "time":0, "_id":"aaa", "student":"aaa" ] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("メソッドが実行される", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("placeimgがnilの場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "status":"aaa", "location":"aaa", "place":"aaa", "placeimg":nil, "time":0, "_id":"aaa", "student":"aaa" ] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("メソッドが実行される", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("timeがnilの場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "status":"aaa", "location":"aaa", "place":"aaa", "placeimg":"aaa", "time":nil, "_id":"aaa", "student":"aaa" ] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("メソッドが実行される", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("_idがnilの場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "status":"aaa", "location":"aaa", "place":"aaa", "placeimg":"aaa", "time":nil, "_id":nil, "student":"aaa" ] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("メソッドが実行される", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("studentがnilの場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "status":"aaa", "location":"aaa", "place":"aaa", "placeimg":nil, "time":0, "_id":"aaa", "student":nil ] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("メソッドが実行される", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toEventually(beNil())
                })
            })
        }
        
        //########################################################################################
        //########################################################################################
        describe("空文字チェック") {
            context("送信パラメータが全て空文字の場合", closure: {
                beforeEach {
                    //                    let body = ["errorCode":nil, "errorMessage":nil, "status":nil, "location":nil, "place":nil, "placeimg":nil, "time":nil, "_id":nil, "student":nil ] as [String : Any?]
                    //                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("通信が失敗する？", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest("", lng: "", lang: "", userid: "", sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(status).toEventually(beNil())
                    expect(location).toEventually(beNil())
                    expect(place).toEventually(beNil())
                    expect(placeimg).toEventually(beNil())
                    expect(time).toEventually(beNil())
                    expect(_id).toEventually(beNil())
                    expect(student).toEventually(beNil())
                })
            })
            
            context("latが空文字の場合", closure: {
                beforeEach {
                    //                    let body = ["errorCode":nil, "errorMessage":nil, "status":nil, "location":nil, "place":nil, "placeimg":nil, "time":nil, "_id":nil, "student":nil ] as [String : Any?]
                    //                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("通信が失敗する？", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest("", lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(status).toEventually(beNil())
                    expect(location).toEventually(beNil())
                    expect(place).toEventually(beNil())
                    expect(placeimg).toEventually(beNil())
                    expect(time).toEventually(beNil())
                    expect(_id).toEventually(beNil())
                    expect(student).toEventually(beNil())
                })
            })
            
            context("lngが空文字の場合", closure: {
                beforeEach {
                    //                    let body = ["errorCode":nil, "errorMessage":nil, "status":nil, "location":nil, "place":nil, "placeimg":nil, "time":nil, "_id":nil, "student":nil ] as [String : Any?]
                    //                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("通信が失敗する？", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: "", lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(status).toEventually(beNil())
                    expect(location).toEventually(beNil())
                    expect(place).toEventually(beNil())
                    expect(placeimg).toEventually(beNil())
                    expect(time).toEventually(beNil())
                    expect(_id).toEventually(beNil())
                    expect(student).toEventually(beNil())
                })
            })
            
            context("langが空文字の場合", closure: {
                beforeEach {
                    //                    let body = ["errorCode":nil, "errorMessage":nil, "status":nil, "location":nil, "place":nil, "placeimg":nil, "time":nil, "_id":nil, "student":nil ] as [String : Any?]
                    //                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("通信が失敗する？", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: "", userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(status).toEventually(beNil())
                    expect(location).toEventually(beNil())
                    expect(place).toEventually(beNil())
                    expect(placeimg).toEventually(beNil())
                    expect(time).toEventually(beNil())
                    expect(_id).toEventually(beNil())
                    expect(student).toEventually(beNil())
                })
            })
            
            context("useridが空文字の場合", closure: {
                beforeEach {
                    //                    let body = ["errorCode":nil, "errorMessage":nil, "status":nil, "location":nil, "place":nil, "placeimg":nil, "time":nil, "_id":nil, "student":nil ] as [String : Any?]
                    //                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("通信が失敗する？", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: "", sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(status).toEventually(beNil())
                    expect(location).toEventually(beNil())
                    expect(place).toEventually(beNil())
                    expect(placeimg).toEventually(beNil())
                    expect(time).toEventually(beNil())
                    expect(_id).toEventually(beNil())
                    expect(student).toEventually(beNil())
                })
            })
            
            context("受信パラメータが全てnilの場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "status":"", "location":"", "place":"", "placeimg":"", "time":"", "_id":"", "student":"" ] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("メソッドが実行される", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("statusが空文字の場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "status":"", "location":"aaa", "place":"aaa", "placeimg":"aaa", "time":0, "_id":"aaa", "student":"aaa" ] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("メソッドが実行される", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("locationが空文字の場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "status":"aaa", "location":"", "place":"aaa", "placeimg":"aaa", "time":0, "_id":"aaa", "student":"aaa" ] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("メソッドが実行される", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("placeが空文字の場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "status":"aaa", "location":"aaa", "place":"", "placeimg":"aaa", "time":0, "_id":"aaa", "student":"aaa" ] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("メソッドが実行される", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("placeimgが空文字の場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "status":"aaa", "location":"aaa", "place":"aaa", "placeimg":"", "time":0, "_id":"aaa", "student":"aaa" ] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("メソッドが実行される", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("timeが空文字の場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "status":"aaa", "location":"aaa", "place":"aaa", "placeimg":"aaa", "time":"", "_id":"aaa", "student":"aaa" ] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("メソッドが実行される", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("_idが空文字の場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "status":"aaa", "location":"aaa", "place":"aaa", "placeimg":"aaa", "time":0, "_id":"", "student":"aaa" ] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("メソッドが実行される", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("studentが空文字の場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "status":"aaa", "location":"aaa", "place":"aaa", "placeimg":"aaa", "time":0, "_id":"aaa", "student":"" ] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                //結果不明
                it("メソッドが実行される", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
        }
        
        //########################################################################################
        //########################################################################################
        
        describe("桁チェックlat") {
            context("latの値がMIN-1桁の場合", closure: {
                var testLat :String?
                beforeEach {
                    testLat = "-179.99999"
                }
                //結果不明
                it("", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(testLat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("latの値がMIN桁の場合", closure: {
                var testLat :String?
                beforeEach {
                    testLat = "-180.000000"
                }
                //結果不明
                it("", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(testLat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("latの値がMIN+1桁の場合", closure: {
                var testLat :String?
                beforeEach {
                    testLat = "-180.0000001"
                }
                //結果不明
                it("", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(testLat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("latの値がMAX-1桁の場合", closure: {
                var testLat :String?
                beforeEach {
                    testLat = "179.99999"
                }
                //結果不明
                it("", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(testLat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("latの値がMAX桁の場合", closure: {
                var testLat :String?
                beforeEach {
                    testLat = "180.000000"
                }
                //結果不明
                it("", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(testLat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("latの値がMAX+1桁の場合", closure: {
                var testLat :String?
                beforeEach {
                    testLat = "180.0000001"
                }
                //結果不明
                it("", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(testLat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
        }
        
        
        //########################################################################################
        //########################################################################################
        describe("桁チェックlng") {
            context("lngの値がMIN-1桁の場合", closure: {
                var testLng :String?
                beforeEach {
                    testLng = "-89.99999"
                }
                //結果不明
                it("", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: testLng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("lngの値がMIN桁の場合", closure: {
                var testLng :String?
                beforeEach {
                    testLng = "-90.000000"
                }
                //結果不明
                it("", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: testLng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("lngの値がMIN+1桁の場合", closure: {
                var testLng :String?
                beforeEach {
                    testLng = "-90.0000001"
                }
                //結果不明
                it("", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: testLng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("lngの値がMAX-1桁の場合", closure: {
                var testLng :String?
                beforeEach {
                    testLng = "89.99999"
                }
                //結果不明
                it("", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: testLng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("lngの値がMAX桁の場合", closure: {
                var testLng :String?
                beforeEach {
                    testLng = "90.000000"
                }
                //結果不明
                it("", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: testLng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("lngの値がMAX+1桁の場合", closure: {
                var testLng :String?
                beforeEach {
                    testLng = "90.0000001"
                }
                //結果不明
                it("", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: testLng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
        }
        
        
        //########################################################################################
        //########################################################################################
        describe("文字チェック") {
            context("latが浮動小数点付き半角数字でない場合", closure: {
                var testLat :String?
                beforeEach {
                    testLat = "aaaaaaa"
                }
                //結果不明
                it("", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(testLat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("lngが浮動小数点付き半角数字でない場合", closure: {
                var testLng :String?
                beforeEach {
                    testLng = "aaaaaaa"
                }
                //結果不明
                it("", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: testLng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("latが半角数字である場合", closure: {
                var testLat :String?
                beforeEach {
                    testLat = "10"
                }
                //結果不明
                it("", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(testLat, lng: self.lng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
            
            context("lngが半角数字である場合", closure: {
                var testLng :String?
                beforeEach {
                    testLng = "10"
                }
                //結果不明
                it("", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    var status: String?
                    var location:NSArray?
                    var place:String?
                    var placeimg:String?
                    var time:Int?
                    var _id:String?
                    var student:String?
                    
                    MergerAPI.searchRequest(self.lat, lng: testLng, lang: self.lang, userid: self.userid, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        status = values["status"] as? String
                        location = values["location"] as? NSArray
                        place = values["place"] as? String
                        placeimg = values["placeimg"] as? String
                        time = values["time"] as? Int
                        _id = values["_id"] as? String
                        student = values["student"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(status).toNotEventually(beNil())
                    expect(location).toNotEventually(beNil())
                    expect(place).toNotEventually(beNil())
                    expect(placeimg).toNotEventually(beNil())
                    expect(time).toNotEventually(beNil())
                    expect(_id).toNotEventually(beNil())
                    expect(student).toNotEventually(beNil())
                })
            })
        }
    }
}
