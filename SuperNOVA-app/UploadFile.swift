//
//  File.swift
//  SwiftTest
//
//  Created by y-okada on 2016/09/24.
//  Copyright © 2016年 SuperNOVA. All rights reserved.
//

import Foundation

//struct UploadFile {
final class UploadFile {
    
    fileprivate let fileNameValue       : String
    fileprivate let nameValue           : String
    fileprivate let dataValue           : Data
    fileprivate let contentTypeValue    : String
    
    // getter, setterあり
    var fileName: String {
        get {
            return fileNameValue;
        }
    }
    
    var name: String {
        get {
            return nameValue;
        }
    }
    
    var data: Data {
        get {
            return dataValue;
        }
    }
    
    var contentType: String {
        get {
            return contentTypeValue;
        }
    }
    
    // TODO: NSDataはclassであるが、そのまま代入で良いか？
    init(fileName : String!, data : Data!, contentType : String!){
        self.fileNameValue      = fileName
        self.nameValue          = fileName
        self.dataValue          = data
        self.contentTypeValue   = contentType
    }
    
    init(fileName : String!, data : Data!, contentType : APIContentType!){
        self.fileNameValue      = fileName
        self.nameValue          = fileName
        self.dataValue          = data
        self.contentTypeValue   = contentType.rawValue
    }
    
    //    init(let fileName : String, let name : String, let data : NSData, let contentType : String){
    //        self.fileName       = fileName
    //        self.name           = name
    //        self.data           = data
    //        self.contentType    = contentType
    //    }
    //
    //    init(let data : NSData, let contentType : String){
    //        self.fileName       = ""
    //        self.name           = ""
    //        self.data           = data
    //        self.contentType    = contentType
    //    }
    //
    //    init(let data : NSData, let contentType : ContentType){
    //        self.fileName       = ""
    //        self.name           = ""
    //        self.data           = data
    //        self.contentType    = contentType.rawValue
    //    }
}
