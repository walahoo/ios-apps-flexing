//
//  DevilWizard.swift
//  rgp oop
//
//  Created by Renee Huang on 6/29/16.
//  Copyright © 2016 Renee Huang. All rights reserved.
//

import Foundation

class DevilWizard : Enemy{
    override var loot: [String]{
        return ["Magic Wand", "Dark Amulet", "Salted Pork"]
    }
    
    override var type: String{
        return "Devil Wizard"
    }
}