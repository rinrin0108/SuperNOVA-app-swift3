//
//  UpdateUserLocationTest.swift
//  SuperNOVA-app
//
//  Created by 朝日田卓哉 on 2017/01/31.
//  Copyright © 2017年 SuperNOVA. All rights reserved.
//

import Quick
import Nimble
import Mockingjay
@testable import SuperNOVA_app


class UpdateUserLocationTest: QuickSpec {
    
    let userid : String = "asahida.test@gmail.com"
    let lat : String = "35.698353"
    let lng : String = "139.773114"
    
    let uri = "https://yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod//updateUserLocation?.*"
    
    override func spec(){
        describe("UserAPI.updateUserLocation") {
            
            context("すべての送信パラメータが正常値であり、errorCodeとerrorMessageがnilであること", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":nil] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                it("通信が成功する", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    UserAPI.updateUserLocation(self.userid, lat: self.lat, lng: self.lng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                })
            })
            
            context("すべての送信パラメータが正常値であり、errorCodeに値が入っている", closure: {
                beforeEach {
                    let body = ["errorCode":503, "errorMessage":nil] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                it("通信が成功する", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    UserAPI.updateUserLocation(self.userid, lat: self.lat, lng: self.lng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        
                    })
                    
                    expect(errorCode).toNotEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                })
            })
            
            context("すべての送信パラメータが正常値であり、errorMessageに値が入っている", closure: {
                beforeEach {
                    let body = ["errorCode":nil, "errorMessage":"error"] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                it("通信が成功する", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    UserAPI.updateUserLocation(self.userid, lat: self.lat, lng: self.lng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toNotEventually(beNil())
                })
            })
        }
        //########################################################################################
        //########################################################################################
        /*
        //そもそもメソッドが落ちる
        describe("nilチェック") { 
            context("送信パラメータが全てnilの場合", closure: {
                beforeEach {
//                    let body = ["errorCode":nil, "errorMessage":"error"] as [String : Any?]
//                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                it("通信が失敗する", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    UserAPI.updateUserLocation(nil, lat: nil, lng: nil, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                })
            })
            
            context("userIdがnilの場合", closure: {
                beforeEach {
//                    let body = ["errorCode":nil, "errorMessage":"error"] as [String : Any?]
//                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                it("通信が失敗する", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    UserAPI.updateUserLocation(nil, lat: self.lat, lng: self.lng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                })
            })
            
            context("latがnilの場合", closure: {
                beforeEach {
//                    let body = ["errorCode":nil, "errorMessage":"error"] as [String : Any?]
//                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                it("通信が失敗する", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    UserAPI.updateUserLocation(self.userid, lat: nil, lng: self.lng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                })
            })
            
            context("lngがnilの場合", closure: {
                beforeEach {
//                    let body = ["errorCode":nil, "errorMessage":"error"] as [String : Any?]
//                    self.stub(http(.get, uri: self.uri), json(body))
                }
                
                it("通信が失敗する", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    UserAPI.updateUserLocation(self.userid, lat: self.lat, lng: nil, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
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
                    UserAPI.updateUserLocation("", lat: "", lng: "", sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                })
            })
            
            context("userIdが空文字の場合", closure: {
                
                it("通信が失敗する", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    UserAPI.updateUserLocation("", lat: self.lat, lng: self.lng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                })
            })
            
            context("latが空文字の場合", closure: {
                
                it("通信が失敗する", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    UserAPI.updateUserLocation(self.userid, lat: "", lng: self.lng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                })
            })
            
            context("lngが空文字の場合", closure: {
                
                it("通信が失敗する", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    UserAPI.updateUserLocation(self.userid, lat: self.lat, lng: "", sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                })
            })
            
            context("受信パラメータが全て空文字の場合", closure: {
                beforeEach {
                    let body = ["errorCode":"", "errorMessage":""] as [String : Any?]
                    self.stub(http(.get, uri: self.uri), json(body))
                }
                it("通信が失敗する", closure: {
                    
                    var errorCode :Int?
                    var errorMessage :String?
                    UserAPI.updateUserLocation(self.userid, lat: self.lat, lng: self.lng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(equal(""))
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
                    UserAPI.updateUserLocation(self.userid, lat: testLat, lng: self.lng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
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
                    UserAPI.updateUserLocation(self.userid, lat: testLat, lng: self.lng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
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
                    UserAPI.updateUserLocation(self.userid, lat: testLat, lng: self.lng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
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
                    UserAPI.updateUserLocation(self.userid, lat: testLat, lng: self.lng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
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
                    UserAPI.updateUserLocation(self.userid, lat: testLat, lng: self.lng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
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
                    UserAPI.updateUserLocation(self.userid, lat: testLat, lng: self.lng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
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
                    UserAPI.updateUserLocation(self.userid, lat: self.lat, lng: testLng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
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
                    UserAPI.updateUserLocation(self.userid, lat: self.lat, lng: testLng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
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
                    UserAPI.updateUserLocation(self.userid, lat: self.lat, lng: testLng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
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
                    UserAPI.updateUserLocation(self.userid, lat: self.lat, lng: testLng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
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
                    UserAPI.updateUserLocation(self.userid, lat: self.lat, lng: testLng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
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
                    UserAPI.updateUserLocation(self.userid, lat: self.lat, lng: testLng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
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
                    UserAPI.updateUserLocation(self.userid, lat: testLat, lng: self.lng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
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
                    UserAPI.updateUserLocation(self.userid, lat: self.lat, lng: testLng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
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
                    UserAPI.updateUserLocation(self.userid, lat: testLat, lng: self.lng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
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
                    UserAPI.updateUserLocation(self.userid, lat: self.lat, lng: testLng, sync: true, success: { (values) in
                        errorCode = values["errorCode"] as? Int
                        errorMessage = values["errorMessage"] as? String
                    }, failed: { (id, message) in
                        errorCode = id
                        errorMessage = message
                    })
                    
                    expect(errorCode).toEventually(beNil())
                    expect(errorMessage).toEventually(beNil())
                })
            })
        }
        
    }
}
