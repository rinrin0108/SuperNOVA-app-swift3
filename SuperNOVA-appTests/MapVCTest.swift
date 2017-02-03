//
//  MapVCTest.swift
//  SuperNOVA-app
//
//  Created by 朝日田卓哉 on 2017/01/25.
//  Copyright © 2017年 SuperNOVA. All rights reserved.
//

import XCTest
import GoogleMaps

@testable import SuperNOVA_app

class MapVCTest: XCTestCase {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var mainVC :MapViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mainVC = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
        UIApplication.shared.keyWindow?.rootViewController = mainVC
        mainVC.performSelector(onMainThread: #selector(mainVC.viewDidAppear(_:)), with: nil, waitUntilDone: true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //######################################VieｗControllerのテスト雛形######################################
    //メソッド実行テスト：メソッドが実行され、画面遷移が行われる
    func testGoAppoint() {
        mainVC.goAppoint(mainVC.push_button)
    }
    //######################################VieｗControllerのテスト雛形######################################
    
    //_animatingがtrueの場合
    func testMapView1(){
        //初期設定
        let marker = GMSMarker()
        marker.icon = UIImage(named:"icon_shop_spot_orange")
        marker.position.latitude = 35.698353
        marker.position.longitude = 139.773114
        marker.title = "aaaa"
        marker.userData = 0000

        mainVC.markerArray.append(marker)
        mainVC.markerindex.append((marker.title)!)
        mainVC.markerimgurl.append("https://s3-ap-northeast-1.amazonaws.com/supernova-hack/noimage.png")
        
        //条件設定
        mainVC._animating = true
        
        
        let result =  mainVC.mapView(mainVC.googleMap, didTap: marker)
        XCTAssertFalse(result)
    }
    
    //_animatingがfalseの場合
    func testMapView2(){
        //初期設定
        let marker = GMSMarker()
        marker.icon = UIImage(named:"icon_shop_spot_orange")
        marker.position.latitude = 35.698353
        marker.position.longitude = 139.773114
        marker.title = "aaaa"
        marker.userData = 0000
        
        mainVC.markerArray.append(marker)
        mainVC.markerindex.append((marker.title)!)
        mainVC.markerimgurl.append("https://s3-ap-northeast-1.amazonaws.com/supernova-hack/noimage.png")
        
        //条件設定
        mainVC._animating = false
        
        
        let result =  mainVC.mapView(mainVC.googleMap, didTap: marker)
        XCTAssertFalse(result)
    }
    
    //titleがnilの場合
    func testMapView3(){
        //初期設定
        let marker = GMSMarker()
        marker.icon = UIImage(named:"icon_shop_spot_orange")
        marker.position.latitude = 35.698353
        marker.position.longitude = 139.773114
        marker.title = nil
        marker.userData = 0000
        
        mainVC.markerArray.append(marker)
        mainVC.markerindex.append((marker.title)!)
        mainVC.markerimgurl.append("https://s3-ap-northeast-1.amazonaws.com/supernova-hack/noimage.png")
        
        
        let result =  mainVC.mapView(mainVC.googleMap, didTap: marker)
        XCTAssertFalse(result)
    }
    
    //titleが空文字の場合
    func testMapView4(){
        //初期設定
        let marker = GMSMarker()
        marker.icon = UIImage(named:"icon_shop_spot_orange")
        marker.position.latitude = 35.698353
        marker.position.longitude = 139.773114
        marker.title = ""
        marker.userData = 0000
        
        mainVC.markerArray.append(marker)
        mainVC.markerindex.append((marker.title)!)
        mainVC.markerimgurl.append("https://s3-ap-northeast-1.amazonaws.com/supernova-hack/noimage.png")
        
        
        let result =  mainVC.mapView(mainVC.googleMap, didTap: marker)
        XCTAssertFalse(result)
    }
    
    //appDelegate._shopimageがnilの場合
    func testMapView5(){
        //初期設定
        let marker = GMSMarker()
        marker.icon = UIImage(named:"icon_shop_spot_orange")
        marker.position.latitude = 35.698353
        marker.position.longitude = 139.773114
        marker.title = "aaaa"
        marker.userData = 0000
        
        mainVC.markerArray.append(marker)
        mainVC.markerindex.append((marker.title)!)
        mainVC.markerimgurl.append("https://s3-ap-northeast-1.amazonaws.com/supernova-hack/noimage.png")
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate._shopimage = nil
        
        let result =  mainVC.mapView(mainVC.googleMap, didTap: marker)
        XCTAssertFalse(result)
    }
    
    //appDelegate._shopimageが空文字の場合
    func testMapView6(){
        //初期設定
        let marker = GMSMarker()
        marker.icon = UIImage(named:"icon_shop_spot_orange")
        marker.position.latitude = 35.698353
        marker.position.longitude = 139.773114
        marker.title = "aaaa"
        marker.userData = 0000
        
        mainVC.markerArray.append(marker)
        mainVC.markerindex.append((marker.title)!)
        mainVC.markerimgurl.append("https://s3-ap-northeast-1.amazonaws.com/supernova-hack/noimage.png")
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate._shopimage = nil
        
        let result =  mainVC.mapView(mainVC.googleMap, didTap: marker)
        XCTAssertFalse(result)
    }
    
    //appDelegateがnilの場合
    func testResponseTeacher1(){
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate._shopimage = nil
        
        mainVC.responseTeacher(mainVC.responseTeacher)
    }
    
    func testResponseTeacher2(){
        mainVC.responseTeacher(mainVC.responseTeacher)
    }
    
}
