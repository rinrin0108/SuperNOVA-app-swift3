//
//  WaitingViewController.swift
//  SuperNOVA-app
//
//  Created by t-kurasawa on 2016/09/25.
//  Copyright © 2016年 SuperNOVA. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import ObjectMapper
import MapKit

class WaitingViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    @IBAction func goAppoint(_ sender: UIButton) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        appDelegate._place = "SHOP01";
        //FIXME
        appDelegate._lat = "35.698353";
        appDelegate._lng = "139.773114";
        
        //FIXME
        UserAPI.updateUserLocation(appDelegate._userid, lat: appDelegate._lat, lng: appDelegate._lng ,sync: true,
            success:{
                values in let closure = {
                    NSLog("MapViewController success");
                    // 通信は成功したが、エラーが返ってきた場合
                    if(API.isError(values)){
                        NSLog("MapViewController isError");
                        /**
                         *  ストーリーボードをまたぐ時に値を渡すためのもの（Indicatorストーリーボードを作成する必要あり）
                            Indicator.windowClose()
                         */
                        AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),                            message: values["errorMessage"] as! String)
                        return
                    }
                    
                    NSLog(values.debugDescription);
                }
                // 通知の監視
                if(!Thread.isMainThread){
                    NSLog("MapViewController !NSThread.isMainThread()");
                    DispatchQueue.main.sync {
                        closure()
                    }
                } else {
                    NSLog("MapViewController closure");
                    closure()   // 恐らく実行されない
                }
            },
            failed: {
                id, message in let closure = {
                    NSLog("MapViewController failed");
                    /**
                     *  ストーリーボードをまたぐ時に値を渡すためのもの（Indicatorストーリーボードを作成する必要あり）
                        Indicator.windowClose()
                     */
                    // 失敗した場合エラー情報を表示
                    if(id == -2) {
                        AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),                                message: NSLocalizedString("MAX_FILE_SIZE_OVER", comment: ""));
                    } else {
                        AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),                                                message: NSLocalizedString("ALERT_MESSAGE_NETWORK_ERROR", comment: ""));
                    }
                }
                // 通知の監視
                if(!Thread.isMainThread){
                    NSLog("MapViewController !NSThread.isMainThread() 2");
                    DispatchQueue.main.sync {
                        NSLog("MapViewController closure 2");
                        closure()
                    }
                } else {
                    NSLog("MapViewController closure 3");
                    closure()   //恐らく実行されない
                }
            }
        )
        
        ViewShowAnimation.changeViewWithIdentiferFromHome(self, toVC: "toCallView")
    }
    //
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //
    var userDefaults = UserDefaults.standard
    
    // GoogleMap
    var lm = CLLocationManager()
    //
    var currentDisplayedPosition: GMSCameraPosition?
    //
    var latitude:   CLLocationDegrees! =  35.698353
    var longitude:  CLLocationDegrees! = 139.773114
    var center = CLLocationCoordinate2DMake(35.698353,139.773114)
    
    @IBOutlet weak var googleMap: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 位置情報サービスを開始するかの確認（初回のみ）
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedAlways {
            lm.requestAlwaysAuthorization()
        }
        
        // 初期設定
        initLocationManager();
        
        // GoogleMapから周辺の地図を取得
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: appDelegate.zoom)
        googleMap.camera = camera;
        googleMap.isIndoorEnabled = false
        googleMap.setMinZoom(15, maxZoom: 19)
        googleMap.isMyLocationEnabled = true
        googleMap.settings.myLocationButton = true
        
        // 周辺施設の表示
        //searchAroudMe(self.googleMap, lat:latitude, lon:longitude);
        
        self.view.addSubview(googleMap)
        
    }
    
    
    func initLocationManager(){
        
        if #available(iOS 9.0, *){
            lm.allowsBackgroundLocationUpdates = true
        }
        //
        lm.delegate = self
        //
        lm.distanceFilter = appDelegate.distance_filter
        //
        lm.startUpdatingLocation()
    }
    
    
    // 座標が取得できない場合の処理
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        NSLog("Error getting Location")
    }
    // 座標を取得した際の処理
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        // 緯度・経度の取得
        latitude  = locations.first?.coordinate.latitude //swift3対応
        longitude = locations.first?.coordinate.longitude //swift3対応
        
        // 中心座標の更新
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: appDelegate.zoom)
        center = CLLocationCoordinate2DMake(latitude,longitude);
        self.googleMap.animate(to: camera)
        
        searchAroudMe(self.googleMap, lat:latitude, lon:longitude);
        // Debug
        //NSLog("latitude: \(latitude), longitude: \(longitude)");
    }
    /*
     internal func onClickLocationButton(sender: UIButton){
     googleMap.animateToLocation(CLLocationCoordinate2DMake(self.latitude, self.longitude))
     }
     */
    
    // 周辺施設呼び出しメソッド
    func searchAroudMe(_ mapView:GMSMapView,lat:CLLocationDegrees,lon:CLLocationDegrees) {
        
        var mposition = CLLocationCoordinate2DMake(lat,lon)
        var marker = GMSMarker()
        
        var page_token:String = ""
        
        repeat {
            let semaphore = DispatchSemaphore(value: 0)
            
            //検索URLの作成
            let encodedStr = "cafes".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat),\(lon)&radius=2000&sensor=true&key=\(appDelegate.googleMapsApiKey)&name=\(encodedStr!)&pagetoken=\(page_token)"
            let searchNSURL = URL(string: url)
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: searchNSURL!, completionHandler: { (data : Data?, response : URLResponse?, error : NSError?) in
                
                if error != nil {
                    print("エラーが発生しました。\(error)")
                } else {
                    if let statusCode = response as? HTTPURLResponse {
                        if statusCode.statusCode != 200 {
                            print("サーバから期待するレスポンスが来ませんでした。\(response)")
                        }
                    }
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        let results = json["results"] as? Array<NSDictionary>
                        
                        //次のページがあるか確認する。
                        if json["next_page_token"] != nil {
                            page_token = json["next_page_token"] as! String
                        } else {
                            page_token = ""
                        }
                        
                        for result in results! {
                            if let geometry = result["geometry"] as? NSDictionary {
                                if let location = geometry["location"] as? NSDictionary {
                                    
                                    //ビンの座標を設定する。
                                    mposition = CLLocationCoordinate2DMake(location["lat"] as! CLLocationDegrees, location["lng"] as! CLLocationDegrees)
                                    NSLog("lat:\(mposition.latitude),lot:\(mposition.longitude)")
                                    NSLog("result:\(result)")
                                }
                            }
                        }
                    } catch {
                        print("error")
                    }
                }
                sleep(1)
                semaphore.signal()
            } as! (Data?, URLResponse?, Error?) -> Void).resume()
            semaphore.wait(timeout: DispatchTime.distantFuture)
        } while (page_token != "")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
