//
//  DetailViewController.swift
//  Project dwei14
//
//  Created by dwei14 on 10/31/19.
//  Copyright © 2019 dwei14. All rights reserved.
//

// This part is to display the detailed information for each city
import UIKit
import CoreData
import MapKit
class DetailViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate  {
    var selectedCity:String?
    var selectDes:String?
    var selectIma:Data?
    
    @IBOutlet weak var imageSource: UISegmentedControl!
    //var newImage: Data?
    var longValue : Double?
    var latiValue : Double?
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var detImage: UIImageView!
    let picker = UIImagePickerController()
    @IBOutlet weak var detDs: UITextView!
    @IBOutlet weak var mapType: UISegmentedControl!
    @IBOutlet weak var map: MKMapView!
    
    let insertContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    var viewContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!
    

    
    /*let insertContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    var viewContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!
    
    //var imageDictionary: [UIImage] = []
    //var currentLoc = 0
    */
    override func viewDidLoad() {
         super.viewDidLoad()
        cityName.text = selectedCity!
        detDs.text = selectDes!
        detImage.image = UIImage(data: selectIma! as Data)
       
        picker.delegate = self
        /*let scheme = "https"
        let host = "www.google.com"
        let path = "/search"
        let queryItem = URLQueryItem(name: "q", value: selectedCity)
        
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [queryItem]
        
        // let url = NSURL(string: urlComponents.url )!
        UIApplication.shared.openURL(urlComponents.url!)
        
         
         // Retrieve the geo information */
        let geoCoder = CLGeocoder();
        //let addressString = "699, S. Mill Ave, Tempe, AZ, 85281"
        let addressString = selectedCity
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
                    
                    self.longValue = ani.coordinate.longitude
                    self.latiValue = ani.coordinate.latitude
                }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        // Do any additional setup after loading the view.
    }
    
    // Add image to the city
    @IBAction func addImage(_ sender: Any) {
        
        if imageSource.selectedSegmentIndex == 0
        {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerController.SourceType.camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                present(picker,animated: true,completion: nil)
            } else {
                print("No camera")
            }
            
        }else{
            //currentLoc = 0
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker, animated: true, completion: nil)
            
        }
    }
    
    // Choose image from the photo library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        
        picker .dismiss(animated: true, completion: nil)
        detImage.image=info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
        
        
    }

    // Save them to core data
    @IBAction func save(_ sender: Any) {
        let ent = NSEntityDescription.entity(forEntityName: "City", in: self.insertContext!)
        
        let newItem = City(entity: ent!, insertInto: self.insertContext!)
        
        newItem.name = selectedCity!
        newItem.des = selectDes!
        let imageData = detImage.image!.pngData()
        
        newItem.image = imageData!
        
        do {
            try self.insertContext?.save()
        } catch _ {
        }
        
        print(newItem)
    }
    
    
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
        
        let lon : CLLocationDegrees = self.longValue!
        
        let lat : CLLocationDegrees = self.latiValue!
        
        let coordinates = CLLocationCoordinate2D( latitude: lat, longitude: lon)
        let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region: MKCoordinateRegion = MKCoordinateRegion.init(center: coordinates, span: span)
        
        self.map.setRegion(region, animated: true)
        
        // add an annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = selectedCity!
        //annotation.subtitle = "AZ"
        
        self.map.addAnnotation(annotation)
    }

}
    
            
       
    
   /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    



fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
