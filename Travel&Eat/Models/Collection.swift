//
//  Collection.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import Foundation

struct Collections: Codable {
    var collections : [CollectionObject]
}


struct CollectionObject: Codable {
    var collection : Collection
}

struct Collection:Codable {
    var collection_id : Int
    var image_url: String
    var title : String?
    var description : String?
}
