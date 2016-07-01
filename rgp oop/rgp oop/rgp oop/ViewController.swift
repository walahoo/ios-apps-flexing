//
//  ViewController.swift
//  rgp oop
//
//  Created by Renee Huang on 6/29/16.
//  Copyright © 2016 Renee Huang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var printLbl: UILabel!
    
    @IBOutlet weak var playerHPLbl: UILabel!
    
    @IBOutlet weak var enemyHPLbl: UILabel!
    
    @IBOutlet weak var enemyImg: UIImageView!
    
    @IBOutlet weak var chestButton: UIButton!
    
    @IBOutlet weak var attackButton: UIButton!
    
    @IBOutlet weak var volumeButton: UIButton!

    var bgSound : AVAudioPlayer!
    var player: Player!
    var enemy: Enemy!
    var chestMessage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = Player(name: "You", hp: 110, attackPwr: 20)
        
        generateRandomEnemy()
        
        playerHPLbl.text = "\(player.hp) HP"
        
        let path = NSBundle.mainBundle().pathForResource("Autumn Nights", ofType:"mp3")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try bgSound = AVAudioPlayer(contentsOfURL: soundURL )
            bgSound.prepareToPlay()
        }catch let err as NSError{
            print (err.debugDescription)
        }
        
        bgSound.play()
    }

    @IBAction func onVolumeButtonPressed(){
        if bgSound.playing{
            bgSound.stop()
        }else{
            bgSound.play()
        }
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

        
        NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "updatePlayerPrintLbl", userInfo: nil, repeats: false)
        
        self.attackButton.enabled = false
        NSTimer.scheduledTimerWithTimeInterval(4.1, target: self, selector: "enableAttackButton", userInfo: nil, repeats: false)
        
    }
    
    func updatePlayerPrintLbl(){
        if enemy.attemptAttack(player.attackPwr) {
            printLbl.text = "You attacked \(enemy.type) for \(player.attackPwr) HP"
            enemyHPLbl.text = "\(enemy.hp) HP"
        } else{
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
            //enemyAttack()
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "enemyAttack", userInfo: nil, repeats: false)
        }
    }
    
    func enemyAttack(){
        if player.attemptAttack(enemy.attackPwr){
           printLbl.text = "\(enemy.type) attacked you for \(enemy.attackPwr) HP"
            playerHPLbl.text = "\(player.hp) HP"
        } else{
            printLbl.text = "Enemy attack was unsuccessful"
        }
    }
    
    func enableAttackButton(){
        self.attackButton.enabled = true
    }
}

