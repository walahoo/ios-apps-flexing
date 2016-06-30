//
//  ViewController.swift
//  rgp oop
//
//  Created by Renee Huang on 6/29/16.
//  Copyright © 2016 Renee Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var printLbl: UILabel!
    
    @IBOutlet weak var playerHPLbl: UILabel!
    
    @IBOutlet weak var enemyHPLbl: UILabel!
    
    @IBOutlet weak var enemyImg: UIImageView!
    
    @IBOutlet weak var chestButton: UIButton!
    
    var player: Player!
    var enemy: Enemy!
    var chestMessage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = Player(name: "You", hp: 110, attackPwr: 20)
        
        generateRandomEnemy()
        
        playerHPLbl.text = "\(player.hp) HP"
    }

    func generateRandomEnemy(){
        let rand = Int(arc4random_uniform(2))
        
        if rand == 0 {
            enemy = Kimara(startingHp: 50, attackPwr: 12)
            printLbl.text = "Your enemy is \(enemy.type), press attack to attack."
            enemyHPLbl.text = "\(enemy.hp) HP "
        } else {
            enemy = DevilWizard(startingHp: 60, attackPwr: 15)
            printLbl.text = "Your enemy is \(enemy.type), press attack to attack."
            enemyHPLbl.text = "\(enemy.hp) HP"
        }
        
        enemyImg.hidden = false
    }

    @IBAction func onChestPressed(sender: UIButton){
        chestButton.hidden = true
        printLbl.text = chestMessage
        NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "generateRandomEnemy", userInfo: nil, repeats: false)
    }
    
    @IBAction func onAttackPressed (sender: UIButton){
        if enemy.attemptAttack(player.attackPwr) {
            printLbl.text = "Attacked \(enemy.type) for \(player.attackPwr) HP"
            NSTimeInterval(3.0)
            enemyHPLbl.text = "\(enemy.hp) HP"
        } else {
            printLbl.text = "Attack was unsuccessful!"
        }

        
        if let loot = enemy.dropLoot(){
            player.addItemToInventory(loot)
            chestMessage = "\(player.name) found \(loot)"
            chestButton.hidden = false
        }
        
        if !enemy.isAlive{
            enemyHPLbl.text = ""
            printLbl.text = "You Killed \(enemy.type)! Gather your loot."
            enemyImg.hidden = true
        } else{
            enemyAttack()
        }
    }
    
    func enemyAttack(){
        if player.attemptAttack(enemy.attackPwr){
            printLbl.text = "\(enemy.type) attacked you for \(player.attackPwr) HP"
            playerHPLbl.text = "\(player.hp) HP"
        } else{
            printLbl.text = "Enemy attack was unsuccessful"
        }
    }
}

