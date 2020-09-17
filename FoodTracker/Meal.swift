//
//  Meal.swift
//  FoodTracker
//
//  Created by Мария Григорьева on 01.09.2020.
//  Copyright © 2020 Мария Григорьева. All rights reserved.
//
import UIKit
import Foundation

struct PropertyKey {
    static let name = "name"
    static let photo = "photo"
    static let rating = "rating"
}

class Meal : NSCoding {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
     
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // Initialization should fail if there is no name or if the rating is negative.
           if name.isEmpty || rating < 0 || rating > 5 {
               return nil
           }
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            print("Unable to decode the name for a Meal object.")
            return nil
        }
        // photo is opt
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        self.init(name: name, photo: photo, rating: rating)
        
    }
    
    func encode (with aCoder: NSCoder){
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
}
