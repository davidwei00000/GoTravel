//
//  MapViewController.swift
//  Project dwei14
//
//  Created by dwei14 on 11/4/19.
//  Copyright © 2019 dwei14. All rights reserved.
//

// This part is to set and retrieve the map information for the App

import UIKit
import MapKit

class MapViewController: UIViewController{
    
    @IBOutlet weak var lati: UITextField!
    @IBOutlet weak var long: UITextField!
    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var map: MKMapView!
    var longValue : Double?
    var latiValue : Double?
    @IBOutlet weak var mapType: UISegmentedControl!
    @IBOutlet weak var weather: UITextField!
    var minlong:Double?
    var Items:NSMutableArray?
    var maxlong:Double?
    var minlati:Double?
    var maxlati:Double?
    var resultA:Double?
    
    
    override func viewDidLoad() {
        resultA = 200;
        /*let geoCoder = CLGeocoder();
        //let addressString = "699, S. Mill Ave, Tempe, AZ, 85281"
        let addressString = cityName.text
        CLGeocoder().geocodeAddressString(addressString!, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    let coords = location!.coordinate
                    print(location)
                    
                    let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                    self.map.setRegion(region, animated: true)
                    let ani = MKPointAnnotation()
                    ani.coordinate = placemark.location!.coordinate
                    ani.title = placemark.locality
                    ani.subtitle = placemark.subLocality
                    
                    self.map.addAnnotation(ani)
                    self.lati.text = String(ani.coordinate.latitude)
                    self.long.text = String(ani.coordinate.longitude)
                    self.longValue = ani.coordinate.longitude
                    self.latiValue = ani.coordinate.latitude
                }
        })*/
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //  Retrieve the geo information and search
    @IBAction func search(_ sender: Any) {
        let geoCoder = CLGeocoder();
        //let addressString = "699, S. Mill Ave, Tempe, AZ, 85281"
        let addressString = cityName.text
        CLGeocoder().geocodeAddressString(addressString!, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    
                    // Get the coordinates for the city
                    let coords = location!.coordinate
                    print(location)
                    
                    let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                    self.map.setRegion(region, animated: true)
                    let ani = MKPointAnnotation()
                    ani.coordinate = placemark.location!.coordinate
                    ani.title = placemark.locality
                    ani.subtitle = placemark.subLocality
                    
                    self.map.addAnnotation(ani)
                    
                    // Set the latitude and longitude information
                    self.lati.text = String(format:"%.2f",ani.coordinate.latitude)
                    self.long.text = String(format:"%.2f",ani.coordinate.longitude)
                    self.longValue = ani.coordinate.longitude
                    self.latiValue = ani.coordinate.latitude
                    print(self.longValue)
                    print(self.latiValue)
                    
                    self.minlong = abs(self.longValue!-100.0)
                    self.maxlong = abs(self.longValue!+100.0)
                    self.minlati = (self.latiValue!-100.0)
                    self.maxlati = (self.latiValue!+100.0)
                    
                    //self.getJsonData()
                    // Call the Weather Web API
                    let urlAsString = "http://api.geonames.org/weatherJSON?north="+String(self.maxlati!)+"&south="+String(self.minlati!)+"&east="+String(self.minlong!)+"&west="+String(self.maxlong!)+"&username=dwei14"
                    
                    print(urlAsString)
                    
                    let url = URL(string: urlAsString)!
                    let urlSession = URLSession.shared
                    
                    let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
                        if (error != nil) {
                            print(error!.localizedDescription)
                        }
                        var err: NSError?
                        
                        
                        let jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                        if (err != nil) {
                            print("JSON Error \(err!.localizedDescription)")
                        }
                        
                        // Show the result for the weather information
                        let weatherResults:NSArray = jsonResult["weatherObservations"] as! NSArray
                        var result:Double = 0.0
                        for i in 0...weatherResults.count-1
                        {
                            let info = weatherResults[i] as? [String: AnyObject]
                            
                            result = result + (info!["temperature"] as? NSString)!.doubleValue
                        }
                        
                        
                        self.resultA = result/Double(weatherResults.count)
                        print(weatherResults)
                        print(result)
                        DispatchQueue.main.async
                            {
                                self.weather.text = String(format:"%.2f",self.resultA!) + " °C"
                        }
                        
                        
                    })
                    
                    jsonQuery.resume()
                }
        })
       // self.weather.text = String(format:"%.2f",resultA!) + "C"
    }
                    
                    // Weather Web API
                    /*let urlAsString = "http://api.geonames.org/weatherJSON?north="+String(self.maxlati!)+"&south="+String(self.minlati!)+"&east="+String(self.minlong!)+"&west="+String(self.maxlong!)+"&username=dwei14"
                    
                    print(urlAsString)
                    
                    let url = URL(string: urlAsString)!
                    let urlSession = URLSession.shared
                    
                    let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
                        if (error != nil) {
                            print(error!.localizedDescription)
                        }
                        var err: NSError?
                        
                        
                        let jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                        if (err != nil) {
                            print("JSON Error \(err!.localizedDescription)")
                        }
                        
                        
                        let weatherResults:NSArray = jsonResult["weatherObservations"] as! NSArray
                        let info = weatherResults[0] as? [String: AnyObject]
                        self.weather.text = info!["temperature"] as! String
                        /*self.Items = jsonResult["messages"] as! NSMutableArray
                         print(self.Items)
                         
                         
                         let setOne:NSArray = jsonResult["messages"] as! NSArray
                         print(setOne);
                         
                         let y = setOne[0] as? [String: AnyObject]
                         //print(y?["placeName"])
                         weather.text =
                         //print(y)*/
                    })
                    */
    //func getJsonData()

    
    
    
    
    // Choose either standard map type or satellite map type
    @IBAction func changeMapType(_ sender: Any) {
        
        switch(mapType.selectedSegmentIndex)
        {
        case 0:
            map.mapType = MKMapType.standard
            
        case 1:
            map.mapType = MKMapType.satellite
            
            
        default:
            map.mapType = MKMapType.standard
        }
        
        // display the map
        let lon : CLLocationDegrees = self.longValue!
        
        let lat : CLLocationDegrees = self.latiValue!
        
        let coordinates = CLLocationCoordinate2D( latitude: lat, longitude: lon)
        let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region: MKCoordinateRegion = MKCoordinateRegion.init(center: coordinates, span: span)
        
        self.map.setRegion(region, animated: true)
        
        // add an annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = cityName.text
        //annotation.subtitle = "AZ"
        
        self.map.addAnnotation(annotation)
    }
    
    
}
