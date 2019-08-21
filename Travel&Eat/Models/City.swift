//
//  City.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import Foundation

//"location_suggestions": [
//{
//"id": 280,
//"name": "New York City, NY",
//"country_id": 216,
//"country_name": "United States",
//"country_flag_url": "https://b.zmtcdn.com/images/countries/flags/country_216.png",
//"should_experiment_with": 0,
//"discovery_enabled": 1,
//"has_new_ad_format": 0,
//"is_state": 0,
//"state_id": 103,
//"state_name": "New York State",
//"state_code": "NY"
//},
struct LocationSuggestion: Codable {
    var location_suggestions : [City]
}


struct City: Codable {
    var id : Int
    var country_id : Int
    var country_name :  String?
    var country_flag_url : String?
    var state_id : Int?
    var state_name : String?
    var state_code : String?
}


