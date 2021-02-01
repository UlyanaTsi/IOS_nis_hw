//
//  Trip.swift
//  Tripgram
//
//  Created by Ульяна Цимбалистая on 31.01.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import UIKit

struct Trip {
    var tripId = " "
    var city = " "
    var country = " "
    var price : Int = 0
    var totalDays : Int = 0
    var isLiked = false
    var featuredImage : UIImage?
    
    init(tripId: String, city: String, country: String, featuredImage: UIImage!, price: Int, totalDays: Int, isLiked : Bool){
        self.tripId = tripId
        self.city = city
        self.country = country
        self.featuredImage = featuredImage
        self.price = price
        self.totalDays = totalDays
        self.isLiked = isLiked
    }
}
