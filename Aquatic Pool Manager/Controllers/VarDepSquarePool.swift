//
//  VarDepSquarePool.swift
//  Pool App Side Menu
//
//  Created by Mac User on 9/8/17.
//  Copyright © 2017 Zeppo. All rights reserved.
//

import Foundation

class VarDepSquarePool : UIViewController {
    
    
    
    
    
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
}
    
    @IBAction func Calculate(_ sender: AnyObject) {
        let varDepSquareDepth = (Double(varDepSquareDepth1.text!)! + Double(varDepSquareDepth2.text!)! / 2)
        
        let VarDepSquareVolume = Double(varDepSquareLength.text!)! * Double(varDepSquareWidth.text!)! * Double(varDepSquareDepth) * 7.5
        
        self.varDepSquareVolume.text = String(format: "%.0f", VarDepSquareVolume)
        
    }
    
    
}
