//
//  RoundPool.swift
//  Pool App Side Menu
//
//  Created by Mac User on 8/31/17.
//  Copyright © 2017 Zeppo. All rights reserved.
//

import Foundation

class RoundPool : UIViewController {
    
    
    
    @IBOutlet weak var menuRoundButton: UIBarButtonItem!
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
        
}
    @IBAction func Calculate(_ sender: AnyObject) {
        
        let RoundPoolVolume = Double(roundPoolLength.text!)! * Double(roundPoolWidth.text!)! * Double(roundPoolDepth.text!)! * 5.9
        
        self.roundPoolVolume.text = String(format: "%.0f", RoundPoolVolume)

    }
    
}
