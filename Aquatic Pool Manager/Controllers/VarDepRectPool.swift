//
//  VarDepRectPool.swift
//  Pool App Side Menu
//
//  Created by Mac User on 9/8/17.
//  Copyright © 2017 Zeppo. All rights reserved.
//

import Foundation
import RealmSwift

class VarDepRectPool : UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var varDepRectName: UITextField!
    @IBOutlet weak var VarDepRectPoolButton: UIBarButtonItem!
    
    @IBOutlet weak var varDepRectLength: UITextField!
    @IBOutlet weak var varDepRectWidth: UITextField!
    @IBOutlet weak var varDepRectDepth1: UITextField!
    @IBOutlet weak var varDepRectDepth2: UITextField!
    @IBOutlet weak var varDepRectVolume: UITextField!
   
    override func viewDidLoad() {
        
        VarDepRectPoolButton.target = revealViewController()
        VarDepRectPoolButton.action = #selector(SWRevealViewController.revealToggle(_:))
        revealViewController().rearViewRevealWidth = 275
        revealViewController().rightViewRevealWidth = 160
        
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
         
       loadPoolData()
        
        
        
}
    
    @IBAction func Calculate(_ sender: AnyObject) {
        
        let VarDepRectDepth = (Double(varDepRectDepth1.text!)! + Double(varDepRectDepth2.text!)! / 2)
        
        let varDepRectVolume1 = Double(varDepRectLength.text!)! * Double(varDepRectWidth.text!)! * Double(VarDepRectDepth) * 7.5
        
        do {
            try self.realm.write {
                let varDepRectPool = PoolName()
                varDepRectPool.type = "varDepRect"
                varDepRectPool.name = String(self.varDepRectName.text!)!
                varDepRectPool.width = Double(self.varDepRectWidth.text!)!
                varDepRectPool.length = Double(self.varDepRectLength.text!)!
                varDepRectPool.depth1 = Double(self.varDepRectDepth1.text!)!
                varDepRectPool.depth2 = Double(self.varDepRectDepth2.text!)!
                varDepRectPool.volume = Double(varDepRectVolume1)
                self.realm.add(varDepRectPool)
            }
        } catch {
            print("Error saving new Pool, \(error)")
        }
        
        loadPoolData()
        
    }
    
    //MARK: - Load Pool Data
    
    func loadPoolData() {
        var a = 1
        
        let varDepRectPool = realm.objects(PoolName.self)
        
        if varDepRectPool.isEmpty {
            varDepRectName.text = "Add New Pool"
        } else {
            
            for pool in varDepRectPool {
                if pool.type == "varDepRect" {
                    varDepRectName.text = pool.name
                    varDepRectWidth.text = String(pool.width)
                    varDepRectLength.text = String(pool.length)
                    varDepRectDepth1.text = String(pool.depth1)
                    varDepRectDepth2.text = String(pool.depth2)
                    varDepRectVolume.text = String(pool.volume)
                    break
                } else {
                    varDepRectName.text = ""
                    varDepRectWidth.text = ""
                    varDepRectLength.text = ""
                    varDepRectDepth1.text = ""
                    varDepRectDepth2.text = ""
                    varDepRectVolume.text = ""
                }
            }
           
        }
        
    }
    //MARK: - Reset Button
    
    @IBAction func resetButton(_ sender: AnyObject) {
        let varDepRectPool = realm.objects(PoolName.self)
        
        if varDepRectPool.isEmpty {
            varDepRectName.text = "No Pool to delete"
        } else {
            
            for pool in varDepRectPool {
                if pool.type == "varDepRect" {
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

        
        

