//
//  MergerApi.swift
//  SuperNOVA-app
//
//  Created by t-kurasawa on 2016/09/24.
//  Copyright © 2016年 SuperNOVA. All rights reserved.
//

import Foundation

class MergerAPI {
    
    /// 教師リクエストAPI<br>
    /// 教師を探す<br>
    /// 引数がnilの引数については更新の対象としない。<br>
    /// <br>
    /// successのクロージャに対して、以下のパラメータを含めコールバックする。<br>
    ///
    /// - parameter userId:         ユーザID(let String!)
    /// - parameter lat:            lat(let String!)
    /// - parameter lng:            lat(let String!)
    /// - parameter lang:           lang(let String!)
    /// - parameter place:          place(let String!)
    /// - parameter img:            img(let String!)
    /// - parameter sync:           同期設定(true=同期,false=非同期)(let Bool!)
    /// - parameter success:        成功時コールバックメソッド(let Dictionary<String,AnyObject>) -> Void!)
    /// - parameter failed:         失敗時コールバックメソッド(let (Int?,String?) -> Void?)
    ///
    static func requestTeacher(_ userId : String!, lat : String?, lng : String?, lang : String?, place : String?,time :String?, img: String?, sync : Bool!, success:((Dictionary<String,AnyObject>) -> Void)!, failed:((Int?,String?) -> Void)?){
        
        //パラメータの設定
        var params : Dictionary<String,String?>= Dictionary<String,String?>()
        params.updateValue(userId,  forKey: "userid")
        params.updateValue(lat!,    forKey: "lat")
        params.updateValue(lng!,    forKey: "lng")
        params.updateValue(lang!,    forKey: "lang")
        params.updateValue(place!,    forKey: "place")
        params.updateValue(time!,    forKey: "time")
        params.updateValue(img!, forKey: "img")
        
        //リクエストの送信
        //API.request("requestTeacher", methodName: APIHTTPMethod.GET, params: params, sync: sync, success: success, failed: failed)
        API.request("requestTeacher", methodName: APIHTTPMethod.POST, params: params, sync: sync, success: success, failed: failed)
    }
    
    /// リクエスト検索API<br>
    /// <br>
    /// successのクロージャに対して、以下のパラメータを含めコールバックする。<br>
    ///
    /// - parameter lat:            lat(let String!)
    /// - parameter lng:            lat(let String!)
    /// - parameter lang:           lang(let String!)
    /// - parameter userid:         userid(let String!)
    /// - parameter sync:           同期設定(true=同期,false=非同期)(let Bool!)
    /// - parameter success:        成功時コールバックメソッド(let Dictionary<String,AnyObject>) -> Void!)
    /// - parameter failed:         失敗時コールバックメソッド(let (Int?,String?) -> Void?)
    ///
    static func searchRequest(_ lat : String?, lng : String?, lang : String?, userid : String?, sync : Bool!, success:((Dictionary<String,AnyObject>) -> Void)!, failed:((Int?,String?) -> Void)?){
        
        //パラメータの設定
        var params : Dictionary<String,String?>= Dictionary<String,String?>()
        params.updateValue(lat!,    forKey: "lat")
        params.updateValue(lng!,    forKey: "lng")
        params.updateValue(lang!,    forKey: "lang")
        params.updateValue(userid!,    forKey: "userid")
 
        //リクエストの送信
        API.request("searchRequest", methodName: APIHTTPMethod.GET, params: params, sync: sync, success: success, failed: failed)
    }
    
    
    /// リクエスト状況を取得API<br>
    /// <br>
    /// successのクロージャに対して、以下のパラメータを含めコールバックする。<br>
    ///
    /// - parameter _id:            _id(let String!)
    /// - parameter sync:           同期設定(true=同期,false=非同期)(let Bool!)
    /// - parameter success:        成功時コールバックメソッド(let Dictionary<String,AnyObject>) -> Void!)
    /// - parameter failed:         失敗時コールバックメソッド(let (Int?,String?) -> Void?)
    ///
    static func getRequestStatus(_ _id : String!,sync : Bool!, success:((Dictionary<String,AnyObject>) -> Void)!, failed:((Int?,String?) -> Void)?){
        
        //パラメータの設定
        var params : Dictionary<String,String?>= Dictionary<String,String?>()
        params.updateValue(_id,  forKey: "_id")
        
        //リクエストの送信
        API.request("getRequestStatus", methodName: APIHTTPMethod.GET, params: params, sync: sync, success: success, failed: failed)
    }
    
    /// 教師からの承諾レスポンスAPI（マッチング成立）<br>
    /// <br>
    /// successのクロージャに対して、以下のパラメータを含めコールバックする。<br>
    ///
    /// - parameter userId:         ユーザID(let String!)
    /// - parameter _id:            _id(let String!)
    /// - parameter sync:           同期設定(true=同期,false=非同期)(let Bool!)
    /// - parameter success:        成功時コールバックメソッド(let Dictionary<String,AnyObject>) -> Void!)
    /// - parameter failed:         失敗時コールバックメソッド(let (Int?,String?) -> Void?)
    ///
    static func responseTeacher(_ userid : String!,_id : String!,sync : Bool!, success:((Dictionary<String,AnyObject>) -> Void)!, failed:((Int?,String?) -> Void)?){
        
        //パラメータの設定
        var params : Dictionary<String,String?>= Dictionary<String,String?>()
        params.updateValue(userid,  forKey: "userid")
        params.updateValue(_id,  forKey: "_id")
        
        //リクエストの送信
        API.request("responseTeacher", methodName: APIHTTPMethod.GET, params: params, sync: sync, success: success, failed: failed)
    }

    
    /// マッチングキャンセルAPI<br>
    /// <br>
    /// successのクロージャに対して、以下のパラメータを含めコールバックする。<br>
    ///
    /// - parameter userId:         ユーザID(let String!)
    /// - parameter _id:            _id(let String!)
    /// - parameter sync:           同期設定(true=同期,false=非同期)(let Bool!)
    /// - parameter success:        成功時コールバックメソッド(let Dictionary<String,AnyObject>) -> Void!)
    /// - parameter failed:         失敗時コールバックメソッド(let (Int?,String?) -> Void?)
    ///
    static func cancelPitching(_ userid : String!,_id : String!,sync : Bool!, success:((Dictionary<String,AnyObject>) -> Void)!, failed:((Int?,String?) -> Void)?){
        
        //パラメータの設定
        var params : Dictionary<String,String?>= Dictionary<String,String?>()
        params.updateValue(userid,  forKey: "userid")
        params.updateValue(_id,  forKey: "_id")
        
        //リクエストの送信
        API.request("cancelPitching", methodName: APIHTTPMethod.GET, params: params, sync: sync, success: success, failed: failed)
    }

    
    /// マッチングキャンセルAPI<br>
    /// <br>
    /// successのクロージャに対して、以下のパラメータを含めコールバックする。<br>
    ///
    /// - parameter _id:            _id(let String!)
    /// - parameter arrive:         arrive(let String!)
    /// - parameter sync:           同期設定(true=同期,false=非同期)(let Bool!)
    /// - parameter success:        成功時コールバックメソッド(let Dictionary<String,AnyObject>) -> Void!)
    /// - parameter failed:         失敗時コールバックメソッド(let (Int?,String?) -> Void?)
    ///
    static func updateArrive(_ _id : String!,arrive : String!, sync : Bool!, success:((Dictionary<String,AnyObject>) -> Void)!, failed:((Int?,String?) -> Void)?){
        
        //パラメータの設定
        var params : Dictionary<String,String?>= Dictionary<String,String?>()
        params.updateValue(_id,  forKey: "_id")
        params.updateValue(arrive,  forKey: "arrive")
        
        //リクエストの送信
        API.request("updateArrive", methodName: APIHTTPMethod.GET, params: params, sync: sync, success: success, failed: failed)
    }
    
    /// マッチングキャンセルAPI<br>
    /// <br>
    /// successのクロージャに対して、以下のパラメータを含めコールバックする。<br>
    ///
    /// - parameter _id:            _id(let String!)
    /// - parameter sync:           同期設定(true=同期,false=非同期)(let Bool!)
    /// - parameter success:        成功時コールバックメソッド(let Dictionary<String,AnyObject>) -> Void!)
    /// - parameter failed:         失敗時コールバックメソッド(let (Int?,String?) -> Void?)
    ///
    static func finishPitching(_ _id : String!, sync : Bool!, success:((Dictionary<String,AnyObject>) -> Void)!, failed:((Int?,String?) -> Void)?){
        
        //パラメータの設定
        var params : Dictionary<String,String?>= Dictionary<String,String?>()
        params.updateValue(_id,  forKey: "_id")
        
        //リクエストの送信
        API.request("finishPitching", methodName: APIHTTPMethod.GET, params: params, sync: sync, success: success, failed: failed)
    }
    
    
    /// ピッチングの到着時間を更新API<br>
    /// <br>
    /// successのクロージャに対して、以下のパラメータを含めコールバックする。<br>
    ///
    /// - parameter _id:            _id(let String!)
    /// - parameter starttime:      starttime(let String!)
    /// - parameter sync:           同期設定(true=同期,false=非同期)(let Bool!)
    /// - parameter success:        成功時コールバックメソッド(let Dictionary<String,AnyObject>) -> Void!)
    /// - parameter failed:         失敗時コールバックメソッド(let (Int?,String?) -> Void?)
    ///
    static func updatePitchStarttime(_ _id : String!,starttime : String!, sync : Bool!, success:((Dictionary<String,AnyObject>) -> Void)!, failed:((Int?,String?) -> Void)?){
        
        //パラメータの設定
        var params : Dictionary<String,String?>= Dictionary<String,String?>()
        params.updateValue(_id,  forKey: "_id")
        params.updateValue(starttime,  forKey: "starttime")
        
        //リクエストの送信
        API.request("finishPitching", methodName: APIHTTPMethod.GET, params: params, sync: sync, success: success, failed: failed)
    }
    
}
