//
//  ViewController.swift
//  Project dwei14
//
//  Created by dwei14 on 10/31/19.
//  Copyright © 2019 dwei14. All rights reserved.
//


// This part is to modify the view controller of the first page

import UIKit
import CoreData
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Set the favorite list
    var myCityList: cities = cities ()
    let insertContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    var viewContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!
    
    @IBOutlet weak var cityTable: UITableView!
    
    // Load the list
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        
        
        if  let fetchResults = (try? viewContext.fetch(fetchRequest)) as? [City]
        {
            
            let x = fetchResults.count
            
            
            print(x)
            if x != 0 {
                
                for i in 0..<x {
                    
                    let l = fetchResults[i]
                    let f10 = city(cn: l.name!, cd: l.des!, cin: l.image!)
                    self.myCityList.cities.append(f10)
                   
                    let indexPath = IndexPath (row: self.myCityList.cities.count - 1, section: 0)
                    //let picture = UIImage(data: l.image  as! Data)
                    
                    // prepare the image array for next functionctionality
                    
                    //imageDictionary += [picture!]
                    //self.loadedImage.image = picture
                    //self.desc.text = picture?.description
                    self.cityTable.beginUpdates()
                    self.cityTable.insertRows(at: [indexPath], with: .automatic)
                    self.cityTable.endUpdates()
                    
                }
                
                
            }
    }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return myCityList.getCount()
    }
    
    //  Set the layout for the detailed information
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityTableViewCell
        cell.layer.borderWidth = 1.0
        cell.cityTitle.text = myCityList.cities[indexPath.row].cityName;
        cell.cityDescription.text = myCityList.cities[indexPath.row].cityDescription
        
        cell.cityImage.image = UIImage(data: myCityList.cities[indexPath.row].cityImageName! as Data)
        
        
        return cell
    }
    // delete table entry
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
    
    // Updates the list
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        myCityList.removeCityObject(indexPath.row)
        
        self.cityTable.beginUpdates()
        self.cityTable.deleteRows(at: [indexPath], with: .automatic)
        self.cityTable.endUpdates()
    }
    
    // SET some buttons
    @IBAction func refresh(_ sender: Any) {
        let alert = UIAlertController(title: "Add City", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Name of the City Here"
        })
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Description of the City Here"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            
            if let name = alert.textFields![0].text, let des2 = alert.textFields![1].text
            {
                    print("Your name: \(name)")
            
                    print("Your description: \(des2)")
                var imagesource : Data? = UIImage(named: "blank.jpg")?.pngData()
                let f6 = city(cn: name, cd: des2, cin: imagesource!)
                self.myCityList.cities.append(f6)
                
                //Method 1
                
                let indexPath = IndexPath (row: self.myCityList.cities.count - 1, section: 0)
                self.cityTable.beginUpdates()
                self.cityTable.insertRows(at: [indexPath], with: .automatic)
                self.cityTable.endUpdates()
                
                
                
                
                //Method 2
                //self.fruitTable.reloadData()
    
            }
        }))
        
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "detailView"){
            let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
            let city = myCityList.cities[selectedIndex.row]
            
            if let viewController: DetailViewController = segue.destination as? DetailViewController {
                viewController.selectedCity = city.cityName;
                viewController.selectDes = city.cityDescription
                viewController.selectIma = city.cityImageName!
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

