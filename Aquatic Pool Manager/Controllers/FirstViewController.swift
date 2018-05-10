//
//  FirstViewController.swift
//  Pool App 3.0
//
//  Created by Mac User on 11/6/16.
//  Copyright © 2016 Zeppo. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var inputTemp: UITextField!
    @IBOutlet weak var inputFreeChlorine: UITextField!
    @IBOutlet weak var inputTotalChlorine: UITextField!
    @IBOutlet weak var inputPH: UITextField!
    @IBOutlet weak var inputAlkalinity: UITextField!
    @IBOutlet weak var inputCalcium: UITextField!
    @IBOutlet weak var inputCyanuricAcid: UITextField!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var inputTempType: UILabel!
   
    
    var resultsCC = 0.0
    var iCC = 0.0
    var temp = 0.0
    var formatTemp = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.textField.delegate = self;
        
        //initializeTextFields()
        
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        revealViewController().rearViewRevealWidth = 275
        revealViewController().rightViewRevealWidth = 160
        
       view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
//    func initializeTextFields() {
//        let digitsOnlyTextField = inputTemp
//        digitsOnlyTextField?.delegate = self
//        //digitsOnlyTextField?.keyboardType = UIKeyboardType.numberPad
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }



        
    
    @IBAction func `tempSwitch`(_ sender: UISwitch) {
        if (sender.isOn == true)
        {
        inputTempType.text = "Farenheit"
            
        }
        else
        {
        inputTempType.text = "Celsius"
            
         }
        
        
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "analyze") {
            
            if inputTempType.text == "Farenheit" {
                temp = Double(inputTemp.text!)!
                formatTemp = String(format: "%.0f °F", temp)
            }
            else
            {
                temp = Double(inputTemp.text!)!
                formatTemp = String(format: "%.0f °C", temp)
                
            }
            
            
            
            //: To pass combined chlorine to secondViewController
            let iFC = Double(inputFreeChlorine.text!)
            let iTC = Double(inputTotalChlorine.text!)
            let iCC = iTC! - iFC!
            let inputCombinedChlorine = String(iCC)
            
            
            
            let ITT = segue.destination as! SecondViewController;
            let FTVC = segue.destination as! SecondViewController;
            let SVC = segue.destination as! SecondViewController;
            let FCVC = segue.destination as! SecondViewController;
            let CCVC = segue.destination as! SecondViewController;
            let PHVC = segue.destination as! SecondViewController;
            let AVC = segue.destination as! SecondViewController;
            let CVC = segue.destination as! SecondViewController;
            let CAVC = segue.destination as! SecondViewController;

            ITT.toPassITT = inputTempType.text!
            FTVC.toPassFT = formatTemp
            SVC.toPass = inputTemp.text!
            FCVC.toPassFC = inputFreeChlorine.text!
            CCVC.toPassCC = inputCombinedChlorine
            PHVC.toPassPH = inputPH.text!
            AVC.toPassA = inputAlkalinity.text!
            CVC.toPassC = inputCalcium.text!
            CAVC.toPassCA = inputCyanuricAcid.text!
            
            
            
            
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count == 0 {
            return true
        }
        //let digitsOnlyTextField = inputTemp
        let currentText = textField.text ?? ""
        print(textField)
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        switch textField {
        case inputTemp:
            
            return prospectiveText.contains("0123456789.") &&
            prospectiveText.count <= 5
            
        default:
            return true
        }
        
//        let allowedCharacters = CharacterSet.decimalDigits
//        let characterSet = CharacterSet(charactersIn: string)
//        return allowedCharacters.isSuperset(of: characterSet)
        
}
    
    //MARK: End of Class
}



extension UIButton {
    func smallRoundButton() {
        self.frame.size = CGSize(width: 25, height: 25)
        self.layer.backgroundColor = UIColor(red: 0, green: 0.5765, blue: 0.9882, alpha: 1).cgColor
        
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.shadowColor = UIColor(red: 0, green: 0.1922, blue: 0.8392, alpha: 1).cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}





