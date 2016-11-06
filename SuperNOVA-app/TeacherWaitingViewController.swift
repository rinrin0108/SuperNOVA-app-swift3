//
//  TeacherWaitingViewController.swift
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

class TeacherWaitingMapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // GoogleMap
    var lm = CLLocationManager()
    //
    @IBOutlet weak var shopName: UILabel!
    var currentDisplayedPosition: GMSCameraPosition?
    //
    var latitude:   CLLocationDegrees!
    var longitude:  CLLocationDegrees!
    var center: CLLocationCoordinate2D!

    var marker = GMSMarker()
    var mcenter: CLLocationCoordinate2D!
    
    @IBOutlet weak var googleMap: GMSMapView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        // 位置情報サービスを開始するかの確認（初回のみ）
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways {
            lm.requestAlwaysAuthorization()
        }
        */
        
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
        let center = CLLocationCoordinate2DMake(latitude,longitude);
        self.googleMap.animate(to: camera)

        callWebService()
        
    
        let mcenter = CLLocationCoordinate2DMake(appDelegate._shoplat,appDelegate._shoplng);
        marker = GMSMarker(position: mcenter)
        marker.icon = UIImage(named: "marker");
        marker.map = self.googleMap
    }

    
    
    @IBAction func checkin(_ sender: UIButton) {
        ViewShowAnimation.changeViewWithIdentiferFromHome(self, toVC: "toEncounterView")
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
                    
                    //print(jsonResult)
                    
                    //print(routes)
                    
                    let routes = jsonResult.mutableArrayValue(forKeyPath: "routes")
                    let overview_polyline = routes.mutableArrayValue(forKeyPath: "overview_polyline")
                    let points = overview_polyline.mutableArrayValue(forKeyPath: "points")
                    //let pointString = points.firstObject as! String
                    print(points)
                    let pointString = points.firstObject as! String
                    
                    
                    //let overViewPolyLine = routes![0]["overview_polyline"]!!["points"] as! String
//                    let overViewPolyLine = (((routes as! NSDictionary)[0] as! NSDictionary)["overview_polyline"] as! NSDictionary)["points"] as! String
                    //print(overViewPolyLine)
                    
                    if pointString != ""{
                        
                        //Call on Main Thread
                        DispatchQueue.main.async {
                            
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
        polyLine.strokeWidth = 5
        polyLine.strokeColor = UIColor.blue
        polyLine.map = self.googleMap
        
        let smarker = GMSMarker()
        let dmarker = GMSMarker()
        dmarker.position = CLLocationCoordinate2D(latitude: appDelegate._shoplat, longitude: appDelegate._shoplng)
        dmarker.title = appDelegate._shoptitle
        //dmarker.snippet = appDelegate._shopsnippet
        dmarker.map = self.googleMap
        
        shopName.text = appDelegate._shoptitle
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
