//
//  RectPool.swift
//  Pool App Side Menu
//
//  Created by Mac User on 8/31/17.
//  Copyright © 2017 Zeppo. All rights reserved.
//

import Foundation


class RectPool : UIViewController {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var menuRectButton: UIBarButtonItem!
    @IBOutlet weak var poolWidth: UITextField!
    @IBOutlet weak var poolLength: UITextField!
    @IBOutlet weak var poolDepth: UITextField!
    @IBOutlet weak var RectPoolVolume: UITextField!
    @IBOutlet weak var RectPoolName: UITextField!
    
    
    
    @IBOutlet weak var savedLength: UITextField!
    @IBOutlet weak var savedWidth: UITextField!
    @IBOutlet weak var savedDepth: UITextField!
    @IBOutlet weak var savedVolume: UITextField!
    @IBOutlet weak var savedPoolName: UITextField!
    
    
    
    
    override func viewDidLoad() {
        
        menuRectButton.target = revealViewController()
        menuRectButton.action = #selector(SWRevealViewController.revealToggle(_:))
        revealViewController().rearViewRevealWidth = 275
        revealViewController().rightViewRevealWidth = 160
        
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
       
        recallDataInStorage()
        
        
    }
    @IBAction func Calculate(_ sender: AnyObject) {
        
        print("Calucate button is working!")
        
        let rectPoolVolume = Double(poolLength.text!)! * Double(poolWidth.text!)! * Double(poolDepth.text!)! * 7.5
        
        self.RectPoolVolume.text = String(format: "%.0f", rectPoolVolume)
        
        //Create an instance of different objects
        
        defaults.set(Double(poolLength.text!), forKey: "Length")
        defaults.set(Double(poolWidth.text!), forKey: "Width")
        defaults.set(Double(poolDepth.text!), forKey: "Depth")
        defaults.set(Double(RectPoolVolume.text!), forKey: "Volume")
        defaults.set(RectPoolName.text!, forKey: "PoolName")
    
        print(poolLength.text!)
        recallDataInStorage()
    }
    
    @IBAction func resetButton(_ sender: AnyObject) {
       
        print("Reset button pushed")
        
        defaults.removeObject(forKey: "Length")
        defaults.removeObject(forKey: "Width")
        defaults.removeObject(forKey: "Depth")
        defaults.removeObject(forKey: "Volume")
        defaults.removeObject(forKey: "PoolName")
        
        recallDataInStorage()
        
    
    }
    
    func recallDataInStorage() {
        if (defaults.double(forKey: "Length") != 0.0) {
            
            print("Length is greater then 0")
            
            let savedRectLength = defaults.double(forKey: "Length")
            let savedRectWidth = defaults.double(forKey: "Width")
            let savedRectDepth = defaults.double(forKey: "Depth")
            let savedRectVolume = defaults.double(forKey: "Volume")
            let savedRectPoolName = defaults.string(forKey: "PoolName")
            
            self.poolLength.text = String(format: "%.1f", savedRectLength)
            self.poolWidth.text = String(format: "%.1f", savedRectWidth)
            self.poolDepth.text = String(format: "%.1f", savedRectDepth)
            self.RectPoolVolume.text = String(format: "%.1f", savedRectVolume)
            self.RectPoolName.text = savedRectPoolName
            
            print("If statement working")
            
        } else {
            print("if statement, not passing")
            let savedRectLength = defaults.double(forKey: "Length")
            let savedRectWidth = defaults.double(forKey: "Width")
            let savedRectDepth = defaults.double(forKey: "Depth")
            let savedRectVolume = defaults.double(forKey: "Volume")
            //let savedRectPoolName = defaults.string(forKey: "PoolName")
            
            self.poolLength.text = String(format: "%.1f", savedRectLength)
            self.poolWidth.text = String(format: "%.1f", savedRectWidth)
            self.poolDepth.text = String(format: "%.1f", savedRectDepth)
            self.RectPoolVolume.text = String(format: "%.1f", savedRectVolume)
            self.RectPoolName.text = "Enter new data"

        }
    } 
    
    

    
    
}
