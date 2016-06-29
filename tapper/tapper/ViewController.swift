//
//  ViewController.swift
//  tapper
//
//  Created by Renee Huang on 6/27/16.
//  Copyright © 2016 Renee Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //properties
    var maxTaps = 0
    var currentTaps = 0
    //outlets

    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var howManyTapsTxt: UITextField!
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var tapBtn: UIButton!
    @IBOutlet weak var tapsLbl: UILabel!
    
    @IBAction func onCoinTapped(sender: UIButton!){
        currentTaps =  1 + currentTaps
        updateTapsLbl()
        
        if isGameOver(){
            restartGame()
        }
    }

    @IBAction func  onPlayBtnPressed(sender: UIButton!){
        
    
    if howManyTapsTxt.text != nil && howManyTapsTxt.text != ""{
    
    logoImg.hidden = true
    playBtn.hidden = true
    howManyTapsTxt.hidden = true
    
    tapBtn.hidden = false
    tapsLbl.hidden = false
        
    maxTaps = Int(howManyTapsTxt.text!)!
    currentTaps = 0
        updateTapsLbl()
        }
    }
    
    func restartGame(){
        maxTaps = 0
        howManyTapsTxt.text = ""
        
        logoImg.hidden = false
        playBtn.hidden = false
        howManyTapsTxt.hidden = false
        
        tapBtn.hidden = true
        tapsLbl.hidden = true
    }
    
    func isGameOver()-> Bool{
        if currentTaps >= maxTaps{
            return true
        }else{
            return false
        }
    }
    
    func updateTapsLbl(){
        tapsLbl.text = "\(currentTaps) Taps"
    
    }
}

