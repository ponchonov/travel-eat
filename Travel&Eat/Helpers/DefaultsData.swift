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
    
    override init() {
        super.init()
    }
    
}
