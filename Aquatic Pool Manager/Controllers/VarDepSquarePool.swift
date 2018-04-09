//
//  VarDepSquarePool.swift
//  Pool App Side Menu
//
//  Created by Mac User on 9/8/17.
//  Copyright © 2017 Zeppo. All rights reserved.
//

import Foundation
import RealmSwift

class VarDepSquarePool : UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var varDepSquarePoolName: UITextField!
    @IBOutlet weak var VarDepSquarePoolButton: UIBarButtonItem!
    @IBOutlet weak var varDepSquareLength: UITextField!
    @IBOutlet weak var varDepSquareWidth: UITextField!
    @IBOutlet weak var varDepSquareDepth1: UITextField!
    @IBOutlet weak var varDepSquareDepth2: UITextField!
    @IBOutlet weak var varDepSquareVolume: UITextField!
    
    
    
    override func viewDidLoad() {
        
        VarDepSquarePoolButton.target = revealViewController()
        VarDepSquarePoolButton.action = #selector(SWRevealViewController.revealToggle(_:))
        revealViewController().rearViewRevealWidth = 275
        revealViewController().rightViewRevealWidth = 160
        
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        loadPoolData()
}
    
    @IBAction func Calculate(_ sender: AnyObject) {
        let varDepSquareDepth = (Double(varDepSquareDepth1.text!)! + Double(varDepSquareDepth2.text!)! / 2)
        
        let varDepSquareVolume = Double(varDepSquareLength.text!)! * Double(varDepSquareWidth.text!)! * Double(varDepSquareDepth) * 7.5
        
        //self.varDepSquareVolume.text = String(format: "%.0f", VarDepSquareVolume)
        
        
        do {
            try self.realm.write {
                let varDepSquarePool = PoolName()
                varDepSquarePool.type = "varDepSquare"
                varDepSquarePool.name = String(self.varDepSquarePoolName.text!)!
                varDepSquarePool.width = Double(self.varDepSquareWidth.text!)!
                varDepSquarePool.length = Double(self.varDepSquareLength.text!)!
                varDepSquarePool.depth1 = Double(self.varDepSquareDepth1.text!)!
                varDepSquarePool.depth2 = Double(self.varDepSquareDepth2.text!)!
                //varDepSquarePool.depth = Double(varDepSquareDepth)
                varDepSquarePool.volume = Double(varDepSquareVolume)
                self.realm.add(varDepSquarePool)
            }
        } catch {
            print("Error saving new Pool, \(error)")
        }
        
        loadPoolData()
        
    }
    
    //MARK: - Load Pool Data
    
    func loadPoolData() {
        let varDepSquarePool = realm.objects(PoolName.self)
        
        if varDepSquarePool.isEmpty {
            varDepSquarePoolName.text = "Add New Pool"
        } else {
            
            for pool in varDepSquarePool {
                if pool.type == "varDepSquare" {
                    varDepSquarePoolName.text = pool.name
                    varDepSquareWidth.text = String(pool.width)
                    varDepSquareLength.text = String(pool.length)
                    varDepSquareDepth1.text = String(pool.depth1)
                    varDepSquareDepth2.text = String(pool.depth2)
                    varDepSquareVolume.text = String(pool.volume)
                    break
                } else {
                    varDepSquarePoolName.text = "Add New Pool"
                    varDepSquareWidth.text = ""
                    varDepSquareLength.text = ""
                    varDepSquareDepth1.text = ""
                    varDepSquareDepth2.text = ""
                    varDepSquareVolume.text = ""
                }
            }
            
        }
        
    
    }
    //MARK: - Reset Button
    
    @IBAction func resetButton(_ sender: AnyObject) {
        let verDepSquarePool = realm.objects(PoolName.self)
        
        if verDepSquarePool.isEmpty {
            varDepSquarePoolName.text = "No Pool to delete"
        } else {
            
            for pool in verDepSquarePool {
                if pool.type == "varDepSquare" {
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
        if varDepSquarePoolName.text == "Add New Pool" {
            varDepSquarePoolName.text = ""
        }
    }
    
}
