//
//  cities.swift
//  Project dwei14
//
//  Created by dwei14 on 10/31/19.
//  Copyright © 2019 dwei14. All rights reserved.
//


// This part is to set two default city information in the favorite list.
// Each city would have city name, descriotion and the image_Name

import Foundation
import UIKit
class cities 
{
    var cities:[city] = []
    init()
    {
        // Load the image for each city
        var imagesource1 : Data? = UIImage(named: "Tempe.jpg")?.pngData()
        var imagesource2 : Data? = UIImage(named: "Flagstaff.jpg")?.pngData()
        //var imagesource3 : Data? = UIImage(named: "blank.jpg")?.pngData()
        //var imagesource4 : Data? = UIImage(named: "blank.jpg")?.pngData()
        //var imagesource5 : Data? = UIImage(named: "blank.jpg")?.pngData()
        let c1 = city(cn: "Tempe", cd: "The city is named after the Vale of Tempe in Greece. Tempe is located in the East Valley section of metropolitan Phoenix; it is bordered by Phoenix and Guadalupe on the west, Scottsdale and the Salt River Pima–Maricopa Indian Community on the north, Chandler on the south, and Mesa on the east. Tempe is also the location of the main campus of Arizona State University.", cin: imagesource1!)
        let c2 = city(cn: "Flagstaff", cd: "The city is named after a ponderosa pine flagpole. Flagstaff lies near the southwestern edge of the Colorado Plateau, along the western side of the largest contiguous ponderosa pine forest in the continental United States.[9] Flagstaff is next to Mount Elden, just south of the San Francisco Peaks, the highest mountain range in the state of Arizona. Humphreys Peak, the highest point in Arizona at 12,633 feet (3,851 m), is about 10 miles (16 km) north of Flagstaff in Kachina Peaks Wilderness.", cin: imagesource2!)
        /*let c3 = city(cn: "Los Angeles", cd: "Los Angeles is the most populous city in California. Los Angeles is the cultural, financial, and commercial center of Southern California. The city is known for its Mediterranean-like climate, ethnic diversity, Hollywood, the entertainment industry, and its sprawling metropolis.", cin: "LosAngeles.jpg")
        let c4 = city(cn: "San Francisco", cd: "San Francisco is the cultural, commercial, and financial center of Northern California. San Francisco is the 13th most populous city in the United States, and the fourth most populous in California, with 883,305 residents as of 2018.", cin: "SanFrancisco.jpg")
        let c5 = city(cn: "Seattle", cd: "Seattle is a seaport city on the West Coast of the United States. It is the seat of King County, Washington. With an estimated 744,955 residents as of 2018, Seattle is the largest city in both the state of Washington and the Pacific Northwest region of North America.", cin: Seattle.jpeg)
        
        self.myCityList.addCity(name: name, desc: "A beautiful City", image: imagesource!)*/
        cities.append(c1)
        cities.append(c2)
        //cities.append(c3)
        //cities.append(c4)
        //cities.append(c5)
        
    }
    func removeCityObject(_ item:Int)
    {
        cities.remove(at: item)
    }
    
    func getCount() -> Int{
        return cities.count
    }
    
}

class city
{
    var cityName:String?
    var cityDescription:String?
    var cityImageName: Data?
    
    init(cn:String, cd:String, cin:Data)
    {
        cityName = cn
        cityDescription = cd
        cityImageName = cin
        
    }
    
 
    
}
