//
//  Kimara.swift
//  rgp oop
//
//  Created by Renee Huang on 6/29/16.
//  Copyright © 2016 Renee Huang. All rights reserved.
//

import Foundation


class Kimara: Enemy {
    
    let IMMUNE_MAX = 15
    
    override var loot: [String] {
        return ["Tough Hide", "Kimara Venom", "Rare Trident"]
    }
    
    override var type: String{
        return "Kimara"
    }
    
    override func attemptAttack(attackPwr: Int) -> Bool {
        if attackPwr >= IMMUNE_MAX{
            return super.attemptAttack(attackPwr)
        }else{
            return false
        }
    }
}
