//
//  GeoApi.swift
//  SuperNOVA-app
//
//  Created by Atsushi Hayashida on 2016/11/04.
//  Copyright © 2016年 SuperNOVA. All rights reserved.
//

import Foundation
class GeoAPI {
    
    /// Google MAP API<br>
    /// <br>
    /// successのクロージャに対して、以下のパラメータを含めコールバックする。<br>
    ///
    /// - parameter latlng:         (let String!)
    /// - parameter shoplatlng:            (let String!)
    /// - parameter mode: (let String!)
    /// - parameter googleMapsApiKey:            (let String!)
    /// - parameter sync:           同期設定(true=同期,false=非同期)(let Bool!)
    /// - parameter success:        成功時コールバックメソッド(let Dictionary<String,AnyObject>) -> Void!)
    /// - parameter failed:         失敗時コールバックメソッド(let (Int?,String?) -> Void?)
    ///
    static func googleMap( latlng : String!,shoplatlng:String!,mode:String!,googleMapsApiKey:String! ,sync : Bool!, success:((Dictionary<String,AnyObject>) -> Void)!, failed:((Int?,String?) -> Void)?){
        
        //パラメータの設定
        var params : Dictionary<String,String?>= Dictionary<String,String?>()
        params.updateValue(latlng,  forKey: "origin")
        params.updateValue(shoplatlng,    forKey: "destination")
        params.updateValue(mode, forKey: "mode")
        params.updateValue(googleMapsApiKey, forKey: "key")
        
        //リクエストの送信
        API.request("json", methodName: APIHTTPMethod.GET, params: params, sync: sync, success: success, failed: failed)
    }
    

}
