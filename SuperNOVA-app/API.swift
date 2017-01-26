    //
    //  UserAPI.swift
    //  Terrace
    //
    //  Created by y-okada on 2016/09/24.
    //  Copyright © 2016年 SuperNOVA. All rights reserved.
    //
    
    import Foundation
    import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

    
    /// APIクラス<br>
    /// APIリクエストを簡略的に使用することを目的としたクラス<br>
    ///
    final class API {
        
        /// コンストラクタ
        /// 該当機能ではインスタンスの生成が不要となる為、privateで宣言
        fileprivate init(){}
        
        fileprivate static let debug_log        : Bool              = true
        
//        private static let using_basic      : Bool              = true
        fileprivate static let using_basic      : Bool              = false
        /// BASIC認証ユーザ
        fileprivate static let basic_user       : String            = "user"
        /// BASIC認証パスワード
        fileprivate static let basic_password   : String            = "pass"
        /// ドメインプロトコル
        fileprivate static let domain_protocol  : String            = "https://"
        //        private static let domain_protocol  : String            = "http://"
        /// デフォルトドメイン
        fileprivate static let domain           : String            = "yizwzmodg9.execute-api.ap-northeast-1.amazonaws.com/prod/";
        //        private static let domain           : String            = "localhost";
        //POST用URL
        fileprivate static let post_domain      : String            = "\(domain_protocol)\(domain)/"
        
        //GET用URL
        fileprivate static let get_domain       : String            = using_basic ? "\(domain_protocol)\(basic_user):\(basic_password)@\(domain)/" : "\(domain_protocol)\(domain)/";
        
        
        fileprivate static let base64EncodedCredential              = "\(basic_user):\(basic_password)".data(using: String.Encoding.utf8)!.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
        fileprivate static let basic_auth_word                      = "Basic \(base64EncodedCredential)"
        
        
        
        
        /// boundary
        fileprivate static let boundary         : NSString          = UUID().uuidString as NSString
        /// boundary data
        fileprivate static let boundaryData     : Data            = "--\(boundary)\r\n".data(using: String.Encoding.utf8)!
        /// formContentType
        fileprivate static let formDataType     : Data            = "Content-Disposition: form-data;".data(using: String.Encoding.utf8)!
        /// タイムアウト時間(秒)
        fileprivate static let timeoutInterval  : TimeInterval    = 40
        
        fileprivate static var isCached         : Bool              = true
        
        fileprivate static let file_max_size    : Int!              = 2097152
        
        
        /// リクエストキャッシュ可否設定<br>
        /// リクエストを行った際にレスポンスをキャッシュするかの可否を設定します。<br>
        /// 当項目を設定することでキャッシュ動作の抑制とキャッシュの削除が行えます。<br>
        /// ※キャッシュの削除はNSURL系統のキャッシュを一括で削除します。
        ///
        /// - parameter cached: キャッシュ可否(trueの場合、キャッシュを実施し、falseの場合キャッシュを削除し、キャッシュを行わないよう抑制する)
        ///
        static func updateCacheStatus(_ cached : Bool){
            isCached = cached
            //キャッシュの削除
            if !cached {
                URLCache.shared.removeAllCachedResponses()
            }
        }
        
        
        /// リクエストメソッド<br>
        /// 各種APIリクエストの元となるリクエストメソッド<br>
        ///
        /// - parameter apiName:    接続先のAPIのURI
        /// - parameter methodName: HTTPメソッド
        /// - parameter params:     リクエストパラメータ(nil許容->パラメータなし)<br>
        ///   URLへのエンコーディングは当メソッドで処理されます。<br>
        ///   例)key1=val1&key2=val2
        /// - parameter sync:       同期設定(true=同期,false=非同期)
        /// - parameter success:    成功時コールバックメソッド(let Dictionary<String,AnyObject>) -> Void?)
        /// - parameter failed:     失敗時コールバックメソッド(let (Int?,String?) -> Void?)
        ///
        /// -returns:
        ///
        static func request(_ apiName :String!,methodName :APIHTTPMethod!,params :Dictionary<String,String?>?,sync : Bool, success:((Dictionary<String,AnyObject>) -> Void)?, failed:((Int?,String?) -> Void)?) -> Void{
            
            NSLog("API request");
            //セッションの作成
            
            let session     : URLSession              = URLSession.shared
            var paramWord   : String                    = methodName.rawValue == APIHTTPMethod.GET.rawValue ? "?" : ""
            var request     : NSMutableURLRequest
            
            //各種パラメータの設定
            if params != nil && !params!.isEmpty{
                NSLog("API params != nil && !params!.isEmpty");
                var isEmpty = true
                //let allowedCharacterSet = NSMutableCharacterSet.alphanumericCharacterSet()
                //allowedCharacterSet.addCharactersInString("-._~")
                params?.forEach({ key,value in
                    let encKey    = key;//.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet)!
                    let encValue  = value != nil
                        ? value!//.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet)!
                        : ""
                    // TODO:ここの部分の記述をもう少し綺麗にかけないか
                    if !isEmpty{
                        NSLog("API isEmpty");
                        paramWord += "&\(encKey)=\(encValue)"
                    }else{
                        NSLog("API isEmpty else");
                        paramWord += "\(encKey)=\(encValue)"
                        isEmpty = false
                    }
                })
                
            }
            
            //パラメータの設定
            //GETのみURLに設定
            //その他はBodyに設定
            if methodName.rawValue == APIHTTPMethod.GET.rawValue{
                NSLog("API methodName.rawValue == APIHTTPMethod.GET.rawValue");
                let urlWord             = get_domain+apiName+paramWord
                NSLog(urlWord.debugDescription);
                let url : URL         = URL(string: urlWord)!
                NSLog(url.debugDescription);
                request                 = NSMutableURLRequest(url: url)
                request.httpMethod      = methodName.rawValue
                request.timeoutInterval = timeoutInterval
                log("URL:\(url)[GET]")
                NSLog(request.debugDescription);
                //キャッシュ制御
                if !isCached {
                    NSLog("API !isCached");
                    request.cachePolicy     = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
                }
                
            }else{
                NSLog("API API methodName.rawValue == APIHTTPMethod.GET.rawValue else");
                let urlWord             = post_domain+apiName
                let url : URL         = URL(string: urlWord)!
                request                 = NSMutableURLRequest(url: url)
                request.httpMethod      = methodName.rawValue
                request.httpBody        = paramWord.data(using: String.Encoding.utf8)
                request.timeoutInterval = timeoutInterval
                log("URL:\(url)[\(methodName.rawValue)]")
                NSLog(request.debugDescription);
                NSLog(params.debugDescription)
                if debug_log && params != nil && !params!.isEmpty{
                    NSLog("API debug_log && params != nil && !params!.isEmpty");
                    params?.forEach({ key,value in
                        let encKey    = key;//.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet)!
                        let encValue  = value != nil
                            ? value!//.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet)!
                            : ""
                        log("param:\(encKey)[\(encValue)]")
                    })
                }
                
                //キャッシュ制御
                if !isCached {
                    NSLog("API !isCached 2");
                    request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
                }
            }
            
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            if using_basic && methodName.rawValue != APIHTTPMethod.GET.rawValue {
                NSLog("API using_basic && methodName.rawValue != APIHTTPMethod.GET.rawValue");
                request.setValue(basic_auth_word, forHTTPHeaderField: "Authorization")
                log("Auth:\(basic_user):\(basic_password)")
            }
            
            //同期する場合
            if sync {
                NSLog("API sync");
                var selfData        : Data?               = nil
                var selfResponse    : URLResponse?        = nil
                var selfErr         : NSError?              = nil
                let semaphore       : DispatchSemaphore! = DispatchSemaphore(value: 0)
                //リクエストの送信
                let task = session.dataTask(with: request as URLRequest, completionHandler: {
                    //レスポンスの処理
                    (data, response, err) in
                    selfData        = data
                    selfResponse    = response
                    selfErr         = err as NSError?
                    
                    if debug_log {
                        NSLog("API debug_log");
                        let res = response as? HTTPURLResponse
                        log("Response")
                        log("ID:\(res?.statusCode)")
                        log("DESC:\(res?.debugDescription)")
                        NSLog("data")
                        NSLog(data.debugDescription)
                        NSLog("err")
                        NSLog(err.debugDescription)
                    }
                    semaphore.signal()
                })
                task.resume()
                semaphore.wait(timeout: DispatchTime.distantFuture)
                if selfErr != nil {
                    NSLog("API selfErr != nil")
                    failed!(selfErr?.code,selfErr?.description)
                    return
                }
                
                //正常なステータス(200)以外の場合はエラークロージャを呼んで終了する
                if let httpResponse = selfResponse as? HTTPURLResponse {
                    if httpResponse.statusCode == 503{
                        NSLog("API httpResponse.statusCode == 503")
                        failed!(httpResponse.statusCode, httpResponse.description)
                        return
                    }
                }
                //JSONの分解
                var json : Dictionary<String,AnyObject> = Dictionary()
                do {
                    if selfData!.count > 2 {
                        json = try JSONSerialization.jsonObject(with: selfData!, options: .mutableContainers) as! Dictionary<String,AnyObject>
                        if debug_log {
                            log(NSString(data: selfData!, encoding: String.Encoding.utf8.rawValue) as! String)
                        }
                    }
                } catch {
                    print("failed parse - \(NSString(data:selfData!, encoding:String.Encoding.utf8.rawValue))")
                }
                success!(json)
            }
                //非同期の場合
            else {
                NSLog("API sync else");
                //リクエストの送信
                let task = session.dataTask(with: request as URLRequest, completionHandler: {
                    //レスポンスの処理
                    (data, response, err) in
                    if debug_log {
                        NSLog("API sync else debug_log");
                        let res = response as? HTTPURLResponse
                        log("Response")
                        log("ID:\(res?.statusCode)")
                        log("DESC:\(res?.debugDescription)")
                        NSLog(data.debugDescription)
                        NSLog(response.debugDescription)
                        NSLog(err.debugDescription)
                    }
                    
                    if err != nil {
                        NSLog("API err != nil");
                        //failed!(err?.code,err?.description)
                        failed!(500,err?.localizedDescription)
                        return
                    }
                    
                    //正常なステータス(200)以外の場合はエラークロージャを呼んで終了する
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 503 {
                            NSLog("API httpResponse.statusCode == 503");
                            failed!(httpResponse.statusCode, httpResponse.description)
                            return
                        }
                    }
                    //JSONの分解
                    var json : Dictionary<String,AnyObject> = Dictionary()
                    do {
                        // FIXME: 空の返却値の対応はこれで良いかを確認
                        if data!.count > 2 {
                            NSLog("API data!.length > 2");
                            json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Dictionary<String,AnyObject>
                            if debug_log {
                                log(NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String)
                            }
                        }
                    } catch  {
                        print("failed parse - \(NSString(data:data!, encoding:String.Encoding.utf8.rawValue))")
                    }
                    success!(json)
                    NSLog("API success!(json)");
                })
                task.resume()
                NSLog("API task.resume()");
            }
        }
        
        /// リクエストメソッド<br>
        /// 各種APIリクエストの元となるリクエストメソッド<br>
        ///
        /// - parameter apiName:    接続先のAPIのURI
        /// - parameter methodName: HTTPメソッド
        /// - parameter params:     リクエストパラメータ(nil許容->パラメータなし)
        /// - parameter datas:      リクエストに設定するバイトデータ(nil許容->パラメータなし)<br>
        ///   URLへのエンコーディングは当メソッドで処理されます。<br>
        ///   例)key1=val1&key2=val2
        /// - parameter sync:       同期設定(true=同期,false=非同期)
        /// - parameter success:    成功時コールバックメソッド(let Dictionary<String,AnyObject>) -> Void?)
        /// - parameter failed:     失敗時コールバックメソッド(let (Int?,String?) -> Void?)
        ///
        /// -returns:
        ///
        static func requestWithData(_ apiName :String!, params :Dictionary<String,String?>?,datas:Array<UploadFile>!,sync : Bool, success:((Dictionary<String,AnyObject>) -> Void)?, failed:((Int?,String?) -> Void)?) -> Void{
            NSLog("API requestWithData");
            
            //        //そもそもバイトデータが存在しない場合は、requestで処理を行う
            //        if datas.isEmpty {
            //            API.request(apiName, methodName: API.HTTPMethod.POST, params: params, success: success, failed: failed)
            //            return
            //        }
            
            let session : URLSession              = URLSession.shared
            let data    : NSMutableData             = NSMutableData()
            let urlWord                             = post_domain+apiName
            let url     : URL                     = URL(string: urlWord)!
            let request : NSMutableURLRequest       = NSMutableURLRequest(url: url)
            request.httpMethod                  = APIHTTPMethod.POST.rawValue
            request.timeoutInterval             = timeoutInterval
            
            
            log("URL:\(url)[POST]")
            NSLog(request.debugDescription);
            
            //各種情報の作成
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            NSLog(request.httpBody.debugDescription);
            if using_basic {
                request.setValue(basic_auth_word, forHTTPHeaderField: "Authorization")
                log("Auth:\(basic_user):\(basic_password)")
            }
            
            //キャッシュ制御
            if !isCached {
                NSLog("API !isCached");
                request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
            }
            
            
            //let allowedCharacterSet = NSMutableCharacterSet.alphanumericCharacterSet()
            //allowedCharacterSet.addCharactersInString("-._~")
            //各種パラメータの設定
            if params != nil && !params!.isEmpty{
                NSLog("API params != nil && !params!.isEmpty");
                params?.forEach({ key,value in
                    let encKey    = key;//.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet)!
                    let encValue  = value != nil
                        ? value!//.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet)!
                        : ""
                    data.append(boundaryData)
                    data.append(formDataType)
                    data.append("name=\"\(encKey)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                    data.append("\(encValue)\r\n".data(using: String.Encoding.utf8)!)
                    log("param:\(encKey)[\(encValue)]")
                })
            }
            //NSLog("\r%@",NSString(data: data, encoding: NSUTF8StringEncoding))
            
            //画像データの設定
            datas.forEach({
                uploadData in
                let encName     = uploadData.name;//.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet)!
                let encFileName = uploadData.fileName;//.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet)!
                data.append(boundaryData)
                data.append(formDataType)
                data.append("name=\"\(encName)\";".data(using: String.Encoding.utf8)!)
                data.append("filename=\"\(encFileName)\"\r\n".data(using: String.Encoding.utf8)!)
                data.append("Content-Type: \(uploadData.contentType)\r\n\r\n".data(using: String.Encoding.utf8)!)
                data.append(uploadData.data as Data)
                data.append("\r\n".data(using: String.Encoding.utf8)!)
            })
            
            //最後にBoundaryをつける
            data.append(boundaryData)
            request.httpBody    = data as Data
            request.setValue(String(data.length), forHTTPHeaderField: "Content-Length")
            //同期する場合
            if sync {
                NSLog("API sync");
                var selfData        : Data?               = nil
                var selfResponse    : URLResponse?        = nil
                var selfErr         : NSError?              = nil
                let semaphore       : DispatchSemaphore! = DispatchSemaphore(value: 0)
                //リクエストの送信
                let task = session.dataTask(with: request as URLRequest, completionHandler: {
                    //レスポンスの処理
                    (data, response, err) in
                    selfData        = data
                    selfResponse    = response
                    selfErr         = err as NSError?
                    semaphore.signal()
                })
                task.resume()
                semaphore.wait(timeout: DispatchTime.distantFuture)
                if selfErr != nil {
                    NSLog("API selfErr != nil");
                    failed!(selfErr?.code,selfErr?.description)
                    return
                }
                
                //正常なステータス(200)以外の場合はエラークロージャを呼んで終了する
                if let httpResponse = selfResponse as? HTTPURLResponse {
                    if httpResponse.statusCode == 503{
                        NSLog("API httpResponse.statusCode == 503");
                        failed!(httpResponse.statusCode, httpResponse.description)
                        return
                    }
                }
                //JSONの分解
                var json : Dictionary<String,AnyObject> = Dictionary()
                do {
                    if selfData!.count > 2 {
                        NSLog("API selfData!.length > 2");
                        json = try JSONSerialization.jsonObject(with: selfData!, options: .mutableContainers) as! Dictionary<String,AnyObject>
                        if debug_log {
                            log(NSString(data: selfData!, encoding: String.Encoding.utf8.rawValue) as! String)
                        }
                    }
                } catch {
                    print("failed parse - \(NSString(data:selfData!, encoding:String.Encoding.utf8.rawValue))")
                }
                success!(json)
            }
                //非同期の場合
            else {
                NSLog("API sync else");
                //リクエストの送信
                let task = session.dataTask(with: request as URLRequest, completionHandler: {
                    //レスポンスの処理
                    (data, response, err) in
                    if debug_log {
                        NSLog("API debug_log");
                        let res = response as? HTTPURLResponse
                        log("Response")
                        log("ID:\(res?.statusCode)")
                        log("DESC:\(res?.debugDescription)")
                        NSLog("data")
                        NSLog(data.debugDescription)
                        NSLog("response")
                        NSLog(response.debugDescription)
                        NSLog("err")
                        NSLog(err.debugDescription)
                    }
                    if err != nil {
                        NSLog("API err != nil")
                        failed!(500,err?.localizedDescription)
                        return
                    }
                    
                    //正常なステータス(200)以外の場合はエラークロージャを呼んで終了する
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 503 {
                            NSLog("API httpResponse.statusCode == 503")
                            failed!(httpResponse.statusCode, httpResponse.description)
                            return
                        }
                    }
                    //JSONの分解
                    var json : Dictionary<String,AnyObject> = Dictionary()
                    do {
                        // FIXME: 空の返却値の対応はこれで良いかを確認
                        if data!.count > 2 {
                            NSLog("API data!.length > 2")
                            json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Dictionary<String,AnyObject>
                            if debug_log {
                                log(NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String)
                            }
                        }
                    } catch  {
                        print("failed parse - \(NSString(data:data!, encoding:String.Encoding.utf8.rawValue))")
                    }
                    success!(json)
                    NSLog("success!(json)");
                })
                task.resume()
                NSLog("task.resume()");
            }
        }
        
        
        /// 配列型をパラメータに変換<br>
        /// 配列を以下のパターンにてdicに追加<br>
        /// キー名:keyName[0~?] 値:arr.value<br>
        ///
        /// - parameter dic:     パラメータディクショナリ(inout)
        /// - parameter keyName: キープレフィックス
        /// - parameter arr:     値配列
        ///
        /// -returns:
        ///
        static func addToDic(_ dic :inout Dictionary<String,String?>, keyName :String!, arr :Array<String>!)->Void{
            var index = 0;
            arr.forEach({
                value in
                dic.updateValue(value, forKey: ("\(keyName)[\(index)]"))
                index += 1
            })
        }
        
        /// 文字列の文字数の超過チェック<br>
        /// 超過をしていた場合、引数のfailedが呼び出され、その後trueが返却される。<br>
        /// 超過をしていない場合、falseが返却される。<br>
        ///
        /// - parameter value:      確認対象の文字列
        /// - parameter length:     対象の設定可能な最大長
        /// - parameter failed:     失敗時の呼び出しコールバック
        ///
        /// - returns:
        ///
        static func validateStringLengthExceed(_ value : String?, length : Int!, failed:((Int?,String?) -> Void)?) -> Bool{
            
            if value?.characters.count > length {
                failed!(-1, "length over.")
                return true
            }
            return false
        }
        
        /// 画像のファイルサイズの超過チェック<br>
        /// 超過をしていた場合、引数のfailedが呼び出され、その後trueが返却される。<br>
        /// 超過をしていない場合、falseが返却される。<br>
        ///
        /// - parameter value:      確認対象の画像データ
        /// - parameter failed:     失敗時の呼び出しコールバック
        ///
        /// - returns:
        ///
        static func validateDataLengthExceed(_ value : Data!, failed:((Int?,String?) -> Void)?) -> Bool{
            
            if value?.count > file_max_size {
                failed!(-2, "length over.")
                return true
            }
            return false
        }
        
        /// Jpeg判定<br>
        /// 引数のdataのバイトデータがJpegであるかを判断する。<br>
        /// Jpegである場合、true、それ以外の場合はfalseを返却する。<br>
        /// 判定にはJpegのマジックパケットを利用する。<br>
        /// マジックパケット：\0xff\0xd8
        ///
        /// - parameter data: 確認対象のバイトNSData
        ///
        /// - returns:
        ///
        /*
        static func isJpeg( _ data : Data! ) -> Bool{
            
            if data.count < 2{
                return false
            }
            
            //var buf : Array<Int8>  = Array<Int8>(repeating: 0, count: 2)
            var buf : Array<Int8>  = Array<Int8>(repeating: 0, count: 2)
            // aBufferにバイナリデータを格納。
            data.copyBytes(to: &buf, count: 2) // &がアドレス演算子みたいに使える。
            return buf[0] == -1 && buf[1] == -40 ? true : false
        }
         */
        
        /// Png判定<br>
        /// 引数のdataのバイトデータがPngであるかを判断する。<br>
        /// Pngである場合、true、それ以外の場合はfalseを返却する。<br>
        /// 判定にはPngのマジックパケットを利用する。<br>
        /// マジックパケット：\0x89PNG\0x0d\0x0a\0x1a\0x0a
        ///
        /// - parameter data: 確認対象のバイトNSData
        ///
        /// - returns:
        ///
        /*
        static func isPng( _ data : Data! ) -> Bool{
            
            if data.count < 8{
                return false
            }
            
            var buf : Array<UInt8>  = Array<UInt8>(repeating: 0, count: 8)
            // aBufferにバイナリデータを格納。
            data.copyBytes(to: &buf, count: 8) // &がアドレス演算子みたいに使える。
            return buf[0] == -119 && buf[1] == 80 && buf[2] == 78 && buf[3] == 71 && buf[4] == 13 && buf[5] == 10 && buf[6] == 26 && buf[7] == 10 ? true : false
        }
         */
        
        /// エラー判定<br>
        /// 引数のparamsがエラー状態であるかを判定する。<br>
        ///
        /// - parameter params: request受信後の正常データ
        ///
        /// - returns: errorCodeが存在するもしくはerrorMessageが存在する場合true、それ以外の場合はfalse
        ///
        static func isError( _ params : Dictionary<String,AnyObject>! ) -> Bool{
            return params.index(forKey: "errorCode") != nil || params.index(forKey: "errorMessage") != nil
        }
        
        
        fileprivate static func log(_ val : String!){
            if debug_log {
                NSLog("%@",val)
            }
        }
        
        /// 画像ダウンロード<br>
        /// 指定したURLの画像をダウンロードする。<br>
        /// 必要な場合、Basic認証を行う。<br>
        ///
        /// - parameter urlWord: ダウンロード対象となるURL
        ///
        /// - returns: 画像のダウンロードが正常に行えた場合、そのインスタンス、ダウンロードを行えなかった場合 nilを返却
        ///
        static func downloadImage(_ urlWord : String!) -> UIImage? {
            
            if urlWord == "" {
                return nil
            }
            
            let url : URL! = URL(string: urlWord)
            
            if using_basic {
                let session     : URLSession              = URLSession.shared
                let request     : NSMutableURLRequest       = NSMutableURLRequest(url: url)
                let semaphore   : DispatchSemaphore!     = DispatchSemaphore(value: 0)
                var selfData    : Data?                   = nil
                //var selfResponse    : NSURLResponse?        = nil
                var selfErr     : NSError?                  = nil
                request.httpMethod                          = APIHTTPMethod.GET.rawValue
                request.timeoutInterval                     = timeoutInterval
                request.setValue(basic_auth_word, forHTTPHeaderField: "Authorization")
                
                //キャッシュ制御
                if !isCached {
                    request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
                }
                
                let task = session.dataTask(with: request as URLRequest, completionHandler: {
                    //レスポンスの処理
                    (data, response, err) in
                    selfData = data
                    selfErr  = err as NSError?
                    semaphore.signal()
                })
                task.resume()
                semaphore.wait(timeout: DispatchTime.distantFuture)
                
                if selfErr != nil || selfData == nil {
                    return nil
                }
                return UIImage(data: selfData!)
            }
            else {
                if let data: Data? = try? Data(contentsOf: url) {
                    return UIImage(data:data!)
                }
            }
            
            return nil
        }
        
        /// 画像ダウンロード<br>
        /// 指定したURLの画像をダウンロードする。<br>
        /// 必要な場合、Basic認証を行う。<br>
        ///
        /// - parameter urlWord: ダウンロード対象となるURL
        ///
        /// - returns: 画像のダウンロードが正常に行えた場合、そのインスタンス、ダウンロードを行えなかった場合 nilを返却
        ///
        static func downloadASyncData(_ urlWord : String!, downloaded:@escaping (Data?) -> Void) {
            
            if urlWord == "" {
                return
            }
            
            let url : URL! = URL(string: urlWord)
            
            if using_basic {
                let session     : URLSession              = URLSession.shared
                let request     : NSMutableURLRequest       = NSMutableURLRequest(url: url)
                request.httpMethod                          = APIHTTPMethod.GET.rawValue
                request.timeoutInterval                     = timeoutInterval
                request.setValue(basic_auth_word, forHTTPHeaderField: "Authorization")
                
                //キャッシュ制御
                if !isCached {
                    request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
                }
                
                let task = session.dataTask(with: request as URLRequest, completionHandler: {
                    //レスポンスの処理
                    (data, response, err) in
                    downloaded(data)
                })
                task.resume()
            }
            else {
                if let data: Data? = try? Data(contentsOf: url) {
                    downloaded(data)
                }
            }
        }
    }
    
