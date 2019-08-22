//
//  Restaurant.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import Foundation

struct Restaurants: Codable {
    var restaurants : [RestaurantObject]
}


struct RestaurantObject: Codable {
    var restaurant : Restaurant
}

struct Restaurant:Codable {
    var id : String
    var name: String
    var url : String?
    var description : String?
    var location : Location
    var highlights : [String]?
    var thumb : String
    var user_rating : Rating
    var photos: [Photos]
}

struct Location:Codable {
    var address : String
    var latitude: String
    var longitude : String
}

struct Rating: Codable {
    var aggregate_rating : String
}

struct Photos: Codable {
    var photo : Photo
}

struct Photo: Codable {
    var url : String
    
}

