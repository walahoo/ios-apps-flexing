//
//  Enemy.swift
//  rgp oop
//
//  Created by Renee Huang on 6/29/16.
//  Copyright © 2016 Renee Huang. All rights reserved.
//

import Foundation

class Enemy : Character{
    var loot: [String]{
        return ["Rusty Dagger", "Cracked Buckler"]
    }
    
    var type: String{
        return "Grunt"
    }
    
    func dropLoot() -> String? {
        if !isAlive{
            let rand = Int(arc4random_uniform(UInt32(loot.count)))
            return loot[rand]
        }
        //otherwise return nil, (also why we applied optional to return value 
        return nil
    }
}