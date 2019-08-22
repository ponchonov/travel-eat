//
//  DefaultsData.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import Foundation

let onboardingViwedKey:String = "onboardingViwedKey"

class DefaultsData: NSObject {
    
    public var onboardingViewed:Bool {
        set (value) {
            UserDefaults.standard.set(value, forKey: onboardingViwedKey)
            UserDefaults.standard.synchronize()
        }
        
        get {
            let value = UserDefaults.standard.bool(forKey: onboardingViwedKey)
            return value
        }
    }
    
    func markAsFavorite(restaurant:Restaurant, favorite:Bool) {
        guard let data = UserDefaults.standard.value(forKey:"songs") as? Data else {
            return
        }
        if var restaurants = try? PropertyListDecoder().decode(Array<Restaurant>.self, from: data) {
            
            if (restaurants.contains(where: {$0.id == restaurant.id}) ) {
                
                if (!favorite) {
                    if let index = restaurants.firstIndex(where: {$0.id ==  restaurant.id}) {
                        restaurants.remove(at: index)
                    }
                }
                
            } else {
                restaurants.append(restaurant)
            }
            UserDefaults.standard.set(try? PropertyListEncoder().encode(restaurants), forKey:"restaurants")
        } else {
            if favorite {
                UserDefaults.standard.set(try? PropertyListEncoder().encode([restaurant]), forKey:"restaurants")
            }
        }
    }
    
    func getFavorites() -> [Restaurant] {
        guard let data = UserDefaults.standard.value(forKey:"songs") as? Data else {
            return []
        }
        if let restaurants = try? PropertyListDecoder().decode(Array<Restaurant>.self, from: data) {
            return restaurants
        }else {
            return []
        }
    }
    
    override init() {
        super.init()
    }
    
}
