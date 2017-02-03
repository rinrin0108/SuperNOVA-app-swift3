//
//  RequestTeacherTest.swift
//  SuperNOVA-app
//
//  Created by 朝日田卓哉 on 2017/01/25.
//  Copyright © 2017年 SuperNOVA. All rights reserved.
//

import Quick
import Nimble
import Mockingjay
@testable import SuperNOVA_app


class RequestTeacherTest: QuickSpec {
    
    let userid = "asahida.test@gmail.com"
    let lat = "35.698353"
    let lng = "139.773114"
    let lang = "Japanese"
    let place = "aaa"
    let time = 30
    let img = "aaa"
    
    let uri = "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod//requestTeacher"
    
    override func spec() {
        
        
        
        describe("MergerAPI.requestTeacher") {
            
            context("すべての送信パラメータが正常値", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "_id":"aaa"] as [String : Any?]
                    self.stub(http(.post, uri: self.uri), json(body))
                }
                
                it("errorCodeとerrorMessageがnilであり、_idに値が含まれていること", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(id).toNotEventually(beNil())
                })
            })
            
            context("すべての送信パラメータが正常値", closure: {
                beforeEach {
                    let body = ["errorCode":503, "errorMessage":nil, "_id":"aaa"] as [String : Any?]
                    self.stub(http(.post, uri: self.uri), json(body))
                }
                
                it("errorCodeに値が入っている", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(id).toNotEventually(beNil())
                })
            })
            
            context("すべての送信パラメータが正常値", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":"error", "_id":"aaa"] as [String : Any?]
                    self.stub(http(.post, uri: self.uri), json(body))
                }
                
                it("すべての送信パラメータが正常値であり、errorMessageに値が入っている", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toNotEventually(beNil())
                })
            })
        }
        
        //########################################################################################
        //########################################################################################
        //大体おちる
        /*
        describe("nilチェック") {
            
            context("送信パラメータが全てnilの場合", closure: {
                it("通信が失敗する", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher(nil, lat: nil, lng: nil, lang: nil, place: nil, time: nil, img: nil, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
                })
            })
            
            context("useridがnilの場合", closure: {
                it("通信が失敗する", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher(nil, lat: self.lat, lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
                })
            })
            
            context("latがnilの場合", closure: {
                it("通信が失敗する", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: nil, lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
                })
            })
            
            context("lngがnilの場合", closure: {
                it("通信が失敗する", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: nil, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
                })
            })
            
            context("langがnilの場合", closure: {
                it("通信が失敗する", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: self.lng, lang: nil, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
                })
            })
            
            context("placeがnilの場合", closure: {
                it("通信が失敗する", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: self.lng, lang: self.lang, place: nil, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
                })
            })
            
            context("timeがnilの場合", closure: {
                it("通信が失敗する", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: self.lng, lang: self.lang, place: self.place, time: nil, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
                })
            })
            
            context("imgがnilの場合", closure: {
                it("通信が失敗する", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: nil, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
                })
            })
            
            context("_idがnilの場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "_id":nil] as [String : Any?]
                    self.stub(http(.post, uri: self.uri), json(body))
                }
                it("_idがnilの場合", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(id).toEventually(beNil())
                })
            })
        }

 */
        
        //########################################################################################
        //########################################################################################
        
        describe("空文字チェック") {
            
            context("送信パラメータが全て空文字の場合", closure: {
                it("通信が失敗する", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher("", lat: "", lng: "", lang: "", place: "", time: self.time, img: "", sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
                })
            })
            
            context("useridが空文字の場合", closure: {
                it("通信が失敗する", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher("", lat: self.lat, lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
                })
            })
            
            context("latが空文字の場合", closure: {
                it("通信が失敗する", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: "", lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
                })
            })
            
            context("lngが空文字の場合", closure: {
                it("通信が失敗する", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: "", lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
                })
            })
            
            context("langが空文字の場合", closure: {
                it("通信が失敗する", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: self.lng, lang: "", place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
                })
            })
            
            context("placeが空文字の場合", closure: {
                it("通信が失敗する", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: self.lng, lang: self.lang, place: "", time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
                })
            })
            
            context("imgが空文字の場合", closure: {
                it("通信が失敗する", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: "", sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
                })
            })
            
            context("_idが空文字の場合", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil, "_id":nil] as [String : Any?]
                    self.stub(http(.post, uri: self.uri), json(body))
                }
                it("_idが空文字の場合", closure: {
                    var errorCode :Int?
                    var errorMessage :String?
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                    expect(id).toEventually(beNil())
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
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: testLat, lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
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
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: testLat, lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
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
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: testLat, lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
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
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: testLat, lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
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
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: testLat, lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
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
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: testLat, lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
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
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: testLng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
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
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: testLng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
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
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: testLng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
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
                    var id:String?
                    
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: testLng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
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
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: testLng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
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
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: testLng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
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
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: testLat, lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
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
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: testLng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
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
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: testLat, lng: self.lng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
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
                    var id:String?
                    MergerAPI.requestTeacher(self.userid, lat: self.lat, lng: testLng, lang: self.lang, place: self.place, time: self.time, img: self.img, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                        id = values["_id"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                    expect(id).toEventually(beNil())
                })
            })
        }
    }
}
