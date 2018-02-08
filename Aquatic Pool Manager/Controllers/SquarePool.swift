//
//  SquarePool.swift
//  Pool App Side Menu
//
//  Created by Mac User on 9/8/17.
//  Copyright © 2017 Zeppo. All rights reserved.
//

import Foundation

class SquarePool : UIViewController {
    
    
    @IBOutlet weak var SquarePoolButton: UIBarButtonItem!
    @IBOutlet weak var squarePoolLength: UITextField!
    @IBOutlet weak var squarePoolWidth: UITextField!
    @IBOutlet weak var squarePoolDepth: UITextField!
    @IBOutlet weak var squarePoolVolume: UITextField!
    
    
    
    
    override func viewDidLoad() {
        
        SquarePoolButton.target = revealViewController()
        SquarePoolButton.action = #selector(SWRevealViewController.revealToggle(_:))
        revealViewController().rearViewRevealWidth = 275
        revealViewController().rightViewRevealWidth = 160
        
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    @IBAction func Calculate(_ sender: AnyObject) {
    
    let SquarePoolVolume = Double(squarePoolLength.text!)! * Double(squarePoolWidth.text!)! * Double(squarePoolDepth.text!)! * 7.5
    
    self.squarePoolVolume.text = String(format: "%.0f", SquarePoolVolume)
}
    
    
}
