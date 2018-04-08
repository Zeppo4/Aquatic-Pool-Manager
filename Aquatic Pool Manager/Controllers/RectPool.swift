//
//  RectPool.swift
//  Pool App Side Menu
//
//  Created by Mac User on 8/31/17.
//  Copyright © 2017 Zeppo. All rights reserved.
//

import Foundation
import RealmSwift


class RectPool : UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var menuRectButton: UIBarButtonItem!
    @IBOutlet weak var poolWidth: UITextField!
    @IBOutlet weak var poolLength: UITextField!
    @IBOutlet weak var poolDepth: UITextField!
    @IBOutlet weak var RectPoolVolume: UITextField!
    @IBOutlet weak var inputPoolName: UITextField!
    
    
    
//MARK: - View Datasource Methods
    
    override func viewDidLoad() {
        
        menuRectButton.target = revealViewController()
        menuRectButton.action = #selector(SWRevealViewController.revealToggle(_:))
        revealViewController().rearViewRevealWidth = 275
        revealViewController().rightViewRevealWidth = 160
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        loadPoolData()
        
    }

    
//MARK: - Calculate button pressed
    
    @IBAction func Calculate(_ sender: AnyObject) {
        
        let rectPoolVolume = Double(poolLength.text!)! * Double(poolWidth.text!)! * Double(poolDepth.text!)! * 7.5
        print(rectPoolVolume)
        
        //self.RectPoolVolume.text = String(format: "%.0f", rectPoolVolume)
        
        
        
        do {
            try self.realm.write {
                let RectPoolName = PoolName()
                RectPoolName.type = "rect"
                RectPoolName.name = String(self.inputPoolName.text!)!
                RectPoolName.width = Double(self.poolWidth.text!)!
                RectPoolName.length = Double(self.poolLength.text!)!
                RectPoolName.depth1 = Double(self.poolDepth.text!)!
                RectPoolName.volume = Double(rectPoolVolume)
                self.realm.add(RectPoolName)
            }
        } catch {
            print("Error saving new Pool, \(error)")
        }
        
        loadPoolData()
    }
    
//MARK: - Reset butten pressed
    
    @IBAction func resetButton(_ sender: AnyObject) {
        let rectPoolName = realm.objects(PoolName.self)
        
        
        if rectPoolName.isEmpty {
            inputPoolName.text = "No Pool to delete"
        } else {
            
            for pool in rectPoolName {
                if pool.type == "rect" {
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
//MARK: - Recall data from realm
    
    func loadPoolData() {
        
        let rectPoolName = realm.objects(PoolName.self)
        
        if rectPoolName.isEmpty {
            inputPoolName.text = "Add New Pool"
        } else {
        
            for pool in rectPoolName {
                if pool.type == "rect" {
                    inputPoolName.text = pool.name
                    poolWidth.text = String(pool.width)
                    poolLength.text = String(pool.length)
                    poolDepth.text = String(pool.depth1)
                    RectPoolVolume.text = String(pool.volume)
                    break
                    } else {
                    
                    poolWidth.text = ""
                    poolLength.text = ""
                    poolDepth.text = ""
                    RectPoolVolume.text = ""
                    inputPoolName.text = "Add New Pool"
                }
            }
        }
        
        }
    
    
    
    //MARK: - End of Class
}
