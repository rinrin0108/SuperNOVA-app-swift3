//
//  WaitingMapController.swift
//  SuperNOVA-app
//
//  Created by t-kurasawa on 2016/09/25.
//  Copyright © 2016年 SuperNOVA. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import Alamofire
import ObjectMapper
import MapKit
import SVProgressHUD

class WaitingMapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
    
    // GoogleMap
    var lm = CLLocationManager()
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var shopImage: UIImageView!
    //
    var currentDisplayedPosition: GMSCameraPosition?
    //
    var latitude:   CLLocationDegrees!
    var longitude:  CLLocationDegrees!
    var center: CLLocationCoordinate2D!
    
    var marker = GMSMarker()
    var mcenter: CLLocationCoordinate2D!
    
    @IBOutlet weak var googleMap: GMSMapView!
    
    @IBAction func waiting(_ sender: UIButton) {
        NSLog("---waiting");
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        
        //let shopimage_encoded = appDelegate._shopimage?.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        
        let shopimage_encoded = appDelegate._shopimage.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.alphanumerics)
        
        NSLog(appDelegate._shopimage.description)
        print(shopimage_encoded)
        
        // 教師リクエストAPI
        MergerAPI.requestTeacher(appDelegate._userid, lat: appDelegate._lat, lng: appDelegate._lng, lang: appDelegate._lang, place: appDelegate._place ,time:String(appDelegate._time), img:shopimage_encoded, sync: true,
                                 success:{
                                    values in let closure = {
                                        NSLog("---CallViewController MergerAPI.requestTeacher success");
                                        // 通信は成功したが、エラーが返ってきた場合
                                        if(API.isError(values)){
                                            NSLog("---CallViewController MergerAPI.requestTeacher isError");
                                            /**
                                             * ストーリーボードをまたぐ時に値を渡すためのもの（Indicatorストーリーボードを作成する必要あり）
                                             Indicator.windowClose()
                                             */
                                            AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),
                                                message: values["errorMessage"] as! String)
                                            return
                                        }
                                        
                                        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
                                        NSLog(values.debugDescription);
                                        appDelegate._id = values["_id"] as! String
                                        
                                    }
                                    // 通知の監視
                                    if(!Thread.isMainThread){
                                        NSLog("---CallViewController !NSThread.isMainThread() in success");
                                        DispatchQueue.main.sync {
                                            closure()
                                        }
                                    } else {
                                        NSLog("---CallViewController closure");
                                        // 恐らく実行されない
                                        closure()
                                    }
                                    
            },
                                 failed: {
                                    id, message in let closure = {
                                        NSLog("---CallViewController MergerAPI.requestTeacher failed");
                                        /**
                                         * ストーリーボードをまたぐ時に値を渡すためのもの（Indicatorストーリーボードを作成する必要あり）
                                         Indicator.windowClose()
                                         */
                                        // 失敗した場合エラー情報を表示
                                        if(id == -2) {
                                            AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),
                                                message: NSLocalizedString("MAX_FILE_SIZE_OVER", comment: ""));
                                        } else {
                                            AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),
                                                message: NSLocalizedString("ALERT_MESSAGE_NETWORK_ERROR", comment: ""));
                                        }
                                    }
                                    // 通知の監視
                                    if(!Thread.isMainThread){
                                        NSLog("---CallViewController !NSThread.isMainThread() in failed");
                                        DispatchQueue.main.sync {
                                            NSLog("---CallViewController dispatch_sync");
                                            closure()
                                        }
                                    } else {
                                        NSLog("---CallViewController dispatch_sync else");
                                        //恐らく実行されない
                                        closure()
                                    }
            }
        )
        
        
        NSLog("---waiting2");
        
        let now = Date() // 現在日時の取得
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        NSLog(dateFormatter.string(from: now))
        var flg = false;
        
        //SVProgressHUD.show(withStatus: "処理中") //これを最前面に表示したい
        
        var flg4api = true;
        //ポーリング
        for i in 0 ..< 90 {
            NSLog(dateFormatter.string(from: now))
            
            if(flg4api){
                Thread.sleep(forTimeInterval: 1)
                
            //リクエスト状況を取得
            MergerAPI.getRequestStatus(appDelegate._id ,sync: true,
                                       success:{
                                        values in let closure = {
                                            NSLog("---CallViewController success");
                                            // 通信は成功したが、エラーが返ってきた場合
                                            if(API.isError(values)){
                                                NSLog("---CallViewController isError");
                                                /**
                                                 * ストーリーボードをまたぐ時に値を渡すためのもの（Indicatorストーリーボードを作成する必要あり）
                                                 Indicator.windowClose()
                                                 */
                                                AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),
                                                    message: values["errorMessage"] as! String)
                                                return
                                            }
                                            
                                            NSLog(values.debugDescription);
                                            self.appDelegate._partner = values["teacher"] as! String
                                            if(values["status"] as! String! == "res"){
                                                flg = true
                                                flg4api = false
                                                NSLog("toEncounterView")
                                                ViewShowAnimation.changeViewWithIdentiferFromHome(self, toVC: "toEncounterView")
                                            }
                                            
                                        }
                                        // 通知の監視
                                        if(!Thread.isMainThread){
                                            NSLog("---CallViewController !NSThread.isMainThread()");
                                            DispatchQueue.main.sync {
                                                closure()
                                            }
                                        } else {
                                            NSLog("---CallViewController closure");
                                            // 恐らく実行されない
                                            closure()
                                        }
                                        
                },
                                       failed: {
                                        id, message in let closure = {
                                            NSLog("---CallViewController failed");
                                            /**
                                             * ストーリーボードをまたぐ時に値を渡すためのもの（Indicatorストーリーボードを作成する必要あり）
                                             Indicator.windowClose()
                                             */
                                            // 失敗した場合エラー情報を表示
                                            if(id == -2) {
                                                AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),
                                                    message: NSLocalizedString("MAX_FILE_SIZE_OVER", comment: ""));
                                            } else {
                                                AlertUtil.alertError(self, title: NSLocalizedString("ALERT_TITLE_ERROR", comment: ""),
                                                    message: NSLocalizedString("ALERT_MESSAGE_NETWORK_ERROR", comment: ""));
                                            }
                                            ViewShowAnimation.changeViewWithIdentiferFromHome(self, toVC: "toMapView")
                                        }
                                        // 通知の監視
                                        if(!Thread.isMainThread){
                                            NSLog("---CallViewController !NSThread.isMainThread() 2");
                                            DispatchQueue.main.sync {
                                                NSLog("---CallViewController closure 2");
                                                closure()
                                            }
                                        } else {
                                            NSLog("---CallViewController closure 3");
                                            //恐らく実行されない
                                            closure()
                                        }
                }
            )
            }

            
            
        }
        if(flg){
        } else {
            appDelegate._notification = "noteacher"
            ViewShowAnimation.changeViewWithIdentiferFromHome(self, toVC: "toMapView")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 初期設定
        initLocationManager();
        latitude  = CLLocationDegrees();
        longitude = CLLocationDegrees();
        
        // GoogleMapから周辺の地図を取得
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: appDelegate.zoom)
        googleMap.camera = camera;
        googleMap.isIndoorEnabled = false
        googleMap.setMinZoom(15, maxZoom: 19)
        googleMap.isMyLocationEnabled = true
        googleMap.settings.myLocationButton = true
        
        //NSLog("Debug TeacherWatingView test")
        //callWebService()
        //NSLog("Debug TeacherWatingView")
        
        self.view.addSubview(googleMap)
        self.googleMap.delegate = self;
    }
    
    func initLocationManager() {
        if #available(iOS 9.0, *) {
            lm.allowsBackgroundLocationUpdates = true
        }
        lm.delegate = self
        lm.distanceFilter = appDelegate.distance_filter
        
        lm.startUpdatingLocation()
    }
    
    // 座標が取得できない場合の処理
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog("Error getting Location")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        latitude = locations.first?.coordinate.latitude //swift3対応
        longitude = locations.first?.coordinate.longitude //swift3対応
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: appDelegate.zoom)
        let center = CLLocationCoordinate2DMake(latitude,longitude);
        self.googleMap.animate(to: camera)
        
        googleMap.clear()
        
        callWebService()
        
        let mcenter = CLLocationCoordinate2DMake(appDelegate._shoplat,appDelegate._shoplng);
        marker = GMSMarker(position: mcenter)
        //marker.icon = UIImage(named: "marker");
        //marker.icon = UIImage(named: "icon_shop_spot_orange")
        //marker.map = self.googleMap
        
    }
    func callWebService(){
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(latitude!),\(longitude!)&destination=\(appDelegate._shoplat!),\(appDelegate._shoplng!)&mode=walking&key=\(appDelegate.googleMapsApiKey)")
        
        let request = URLRequest(url: url!)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
            
            // notice that I can omit the types of data, response and error
            do{
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    
                    print(jsonResult)
                    
//                    let routes = jsonResult.value(forKey: "routes")
//                    print(routes)
                    let routes = jsonResult.mutableArrayValue(forKeyPath: "routes")
                    let overview_polyline = routes.mutableArrayValue(forKeyPath: "overview_polyline")
                    let points = overview_polyline.mutableArrayValue(forKeyPath: "points")
                    print("pointspointspoints")
                    print(points)
                    let pointString = points.firstObject as! String
                    
                    if pointString != ""{
                        
                        //Call on Main Thread
                        DispatchQueue.main.async {
                            print("heyheyhey")
                            print(pointString )
                            self.addPolyLineWithEncodedStringInMap(pointString)
                        }
                    }
                }
            }
            catch{
                print("Somthing wrong")
            }
        });
        // do whatever you need with the task e.g. run
        task.resume()
    }
    func addPolyLineWithEncodedStringInMap(_ encodedString: String) {
        
        let path = GMSMutablePath(fromEncodedPath: encodedString)
        let polyLine = GMSPolyline(path: path)
        polyLine.strokeWidth = 6
        //polyLine.strokeColor = UIColor.blue
        polyLine.strokeColor = UIColor.origin_orangeColor()
        polyLine.map = self.googleMap
        
        let smarker = GMSMarker()
        let dmarker = GMSMarker()
        dmarker.position = CLLocationCoordinate2D(latitude: appDelegate._shoplat, longitude: appDelegate._shoplng)
        dmarker.title = appDelegate._shoptitle
        //dmarker.icon = UIImage(named: "icon_shop_spot_orange")
        
        let tmpImage = UIImage(named:"usagi_icon");//UIImage(named:"icon_shop_spot_orange");
        let size = CGSize(width: self.appDelegate._uiw, height: self.appDelegate._uih)
        UIGraphicsBeginImageContext(size)
        tmpImage?.draw(in: CGRect(x: 0,y: 0,width: size.width,height: size.height))
        var resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        dmarker.icon = resizeImage
        //dmarker.snippet = appDelegate._shopsnippet
        dmarker.map = self.googleMap
        
        shopName.text = appDelegate._shoptitle
        
        let imageData :Data = try! Data(contentsOf: URL(string: appDelegate._shopimage as! String)! );
        shopImage.image = UIImage(data:imageData)
        
    }
    
}
