//
//  RoundPool.swift
//  Pool App Side Menu
//
//  Created by Mac User on 8/31/17.
//  Copyright © 2017 Zeppo. All rights reserved.
//

import Foundation
import RealmSwift

class RoundPool : UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var menuRoundButton: UIBarButtonItem!
    @IBOutlet weak var roundPoolName: UITextField!
    @IBOutlet weak var roundPoolLength: UITextField!
    @IBOutlet weak var roundPoolWidth: UITextField!
    @IBOutlet weak var roundPoolDepth: UITextField!
    @IBOutlet weak var roundPoolVolume: UITextField!
    
    
    
    
    override func viewDidLoad() {
     
        menuRoundButton.target = revealViewController()
        menuRoundButton.action = #selector(SWRevealViewController.revealToggle(_:))
        revealViewController().rearViewRevealWidth = 275
        revealViewController().rightViewRevealWidth = 160
        
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        loadPoolData()
        
}
//MARK: - Calculate button pressed
    
    @IBAction func Calculate(_ sender: AnyObject) {
        
        let RoundPoolVolume = Double(roundPoolLength.text!)! * Double(roundPoolWidth.text!)! * Double(roundPoolDepth.text!)! * 5.9
        
        //self.roundPoolVolume.text = String(format: "%.0f", RoundPoolVolume)
        
        do {
            try self.realm.write {
                let roundPool = PoolName()
                roundPool.type = "round"
                roundPool.name = String(self.roundPoolName.text!)!
                roundPool.width = Double(self.roundPoolWidth.text!)!
                roundPool.length = Double(self.roundPoolLength.text!)!
                roundPool.depth1 = Double(self.roundPoolDepth.text!)!
                roundPool.volume = Double(RoundPoolVolume)
                self.realm.add(roundPool)
            }
        } catch {
            print("Error saving new Pool, \(error)")
        }
        
        loadPoolData()

    }

//MARK: - Load Pool Data
    
    func loadPoolData() {
        
        let roundPool = realm.objects(PoolName.self)
        
        if roundPool.isEmpty {
            roundPoolName.text = "Add New Pool"
        } else {
            
            for pool in roundPool {
                if pool.type == "round" {
                    
                    roundPoolName.text = pool.name
                    roundPoolWidth.text = String(pool.width)
                    roundPoolLength.text = String(pool.length)
                    roundPoolDepth.text = String(pool.depth1)
                    roundPoolVolume.text = String(pool.volume)
                    break
                } else {
                    
                    roundPoolName.text = ""
                    roundPoolWidth.text = ""
                    roundPoolLength.text = ""
                    roundPoolDepth.text = ""
                    roundPoolVolume.text = ""
                }
            }
            
        }
        
    }
    // MARK: - Reset Button
    
    @IBAction func resetButton(_ sender: AnyObject) {
        let roundPool = realm.objects(PoolName.self)
        
        
        if roundPool.isEmpty {
            roundPoolName.text = "No Pool to delete"
        } else {
            
            for pool in roundPool {
                if pool.type == "round" {
                    do {
                        try realm.write {
                            realm.delete(pool)
                        }
                    } catch {
                        print("Error deleting data, \(error)")
                    }
                } else {
                    print("not rect type")
                }
            }
            
        }
        
        loadPoolData()
    }
    
    
    
}
