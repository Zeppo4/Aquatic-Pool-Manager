//
//  SquarePool.swift
//  Pool App Side Menu
//
//  Created by Mac User on 9/8/17.
//  Copyright © 2017 Zeppo. All rights reserved.
//

import Foundation
import RealmSwift

class SquarePool : UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var squarePoolName: UITextField!
    @IBOutlet weak var SquarePoolButton: UIBarButtonItem!
    @IBOutlet weak var squarePoolLength: UITextField!
    @IBOutlet weak var squarePoolWidth: UITextField!
    @IBOutlet weak var squarePoolDepth: UITextField!
    @IBOutlet weak var squarePoolVolume: UITextField!

    //MARK: - View Did Load
    
    override func viewDidLoad() {
        
        SquarePoolButton.target = revealViewController()
        SquarePoolButton.action = #selector(SWRevealViewController.revealToggle(_:))
        revealViewController().rearViewRevealWidth = 275
        revealViewController().rightViewRevealWidth = 160
        
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        loadPoolData()
    }
    //MARK: - Calculate button
    
    @IBAction func Calculate(_ sender: AnyObject) {
    
    let SquarePoolVolume = Double(squarePoolLength.text!)! * Double(squarePoolWidth.text!)! * Double(squarePoolDepth.text!)! * 7.5
    
        do {
            try self.realm.write {
                let squarePool = PoolName()
                squarePool.type = "square"
                squarePool.name = String(self.squarePoolName.text!)!
                squarePool.width = Double(self.squarePoolWidth.text!)!
                squarePool.length = Double(self.squarePoolLength.text!)!
                squarePool.depth1 = Double(self.squarePoolDepth.text!)!
                squarePool.volume = Double(SquarePoolVolume)
                self.realm.add(squarePool)
            }
        } catch {
            print("Error saving new Pool, \(error)")
        }
        
        loadPoolData()
        
}
 
    //MARK: - Load Pool Data
    
    func loadPoolData() {
        
        let squarePool = realm.objects(PoolName.self)
        
        if squarePool.isEmpty {
            squarePoolName.text = "Add New Pool"
        } else {
            
            for pool in squarePool {
                if pool.type == "square" {
                    squarePoolName.text = pool.name
                    squarePoolWidth.text = String(pool.width)
                    squarePoolLength.text = String(pool.length)
                    squarePoolDepth.text = String(pool.depth1)
                    squarePoolVolume.text = String(pool.volume)
                    break
                } else {
                    squarePoolName.text = "Add New Pool"
                    squarePoolWidth.text = ""
                    squarePoolLength.text = ""
                    squarePoolDepth.text = ""
                    squarePoolVolume.text = ""
                }
            }
            
        }
        
    }
    //MARK: - Reset Button
    
    @IBAction func resetButton(_ sender: AnyObject) {
        
        let squarePool = realm.objects(PoolName.self)
    
        if squarePool.isEmpty {
            squarePoolName.text = "No Pool to delete"
            } else {
    
            for pool in squarePool {
                if pool.type == "square" {
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
    
    @IBAction func poolNamePressed(_ sender: Any) {
        if squarePoolName.text == "Add New Pool" {
            squarePoolName.text = ""
        }
    }
}

