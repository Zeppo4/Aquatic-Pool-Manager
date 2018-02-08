//
//  VarDepRectPool.swift
//  Pool App Side Menu
//
//  Created by Mac User on 9/8/17.
//  Copyright © 2017 Zeppo. All rights reserved.
//
import UIKit
import Foundation
import CoreData

class VarDepRectPool : UIViewController {
    
    
    
    @IBOutlet weak var VarDepRectPoolButton: UIBarButtonItem!
    
    @IBOutlet weak var varDepRectLength: UITextField!
    @IBOutlet weak var varDepRectWidth: UITextField!
    @IBOutlet weak var varDepRectDepth1: UITextField!
    @IBOutlet weak var varDepRectDepth2: UITextField!
    @IBOutlet weak var varDepRectVolume: UITextField!
    
    @IBOutlet weak var cdLength: UITextField!
    @IBOutlet weak var cdWidth: UITextField!
    @IBOutlet weak var cdDepth: UITextField!
    @IBOutlet weak var cdVolume: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        
        VarDepRectPoolButton.target = revealViewController()
        VarDepRectPoolButton.action = #selector(SWRevealViewController.revealToggle(_:))
        revealViewController().rearViewRevealWidth = 275
        revealViewController().rightViewRevealWidth = 160
        
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
         
        
        
        
        
}
    
    @IBAction func Calculate(_ sender: AnyObject) {
        
        let VarDepRectDepth = (Double(varDepRectDepth1.text!)! + Double(varDepRectDepth2.text!)! / 2)
        
        let varDepRectVolume1 = Double(varDepRectLength.text!)! * Double(varDepRectWidth.text!)! * Double(VarDepRectDepth) * 7.5
        
        self.varDepRectVolume.text = String(format: "%.0f", varDepRectVolume1)
        
        //Saving to Core Data
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Pool")
        
        request.returnsObjectsAsFaults = false

        
        
        
        let newPool = NSEntityDescription.insertNewObject(forEntityName: "Pool", into: context)
        
        newPool.setValue(Double(varDepRectLength.text!)!, forKey: "length")
        newPool.setValue(Double(varDepRectWidth.text!)!, forKey: "width")
        newPool.setValue(Double(varDepRectDepth1.text!), forKey: "depth1")
        newPool.setValue(Double(varDepRectDepth2.text!), forKey: "depth2")
        newPool.setValue(Double(varDepRectVolume.text!)!, forKey: "volume")
        
        
        do
        {
         try context.save()
           print ("SAVED")
        }
        catch
        {
        //Process error
        }
    
    //Retreving datat from core data
    
        
        
        request.returnsObjectsAsFaults = false
        
        
        do
        {
            let results = try context.fetch(request)
            
            if results.count > 0
            {
                for result in results as! [NSManagedObject]
                {
                    if let length = result.value(forKey: "length")
                    {
                        print(length)
                    }
                    if let width = result.value(forKey: "width")
                    {
                        
                        print(width)
                    }
                    if let depth1 = result.value(forKey: "depth1")
                    {
                        
                        print(depth1)
                    }
                    if let depth2 = result.value(forKey: "depth2")
                    {
                        
                        print(depth2)
                    }

                    if let volume = result.value(forKey: "volume")
                    {
                        
                        print(volume)
                    }
                }
            }
        }
        catch
        {
            //Process error
        }


    }
    
}


