//
//  SecondViewController.swift
//  Pool App 3.0
//
//  Created by Mac User on 11/6/16.
//  Copyright © 2016 Zeppo. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    
    @IBOutlet weak var resultsDate: UITextField!
    @IBOutlet weak var resultsTemp: UILabel!
    @IBOutlet weak var resultsFreeChlorine: UITextField!
    @IBOutlet weak var resultsTotalChlorine: UITextField!
    @IBOutlet weak var resultsPH: UITextField!
    @IBOutlet weak var resultsAlkalinity: UITextField!
    @IBOutlet weak var resultsCalcium: UITextField!
    @IBOutlet weak var resultsCyanuricAcid: UITextField!
    @IBOutlet weak var resultsSaturationIndex: UITextField!
    @IBOutlet weak var resultsSIAnalysis: UITextField!
    @IBOutlet weak var resultsTCAnalysis: UITextField!
    @IBOutlet weak var resultsFCAnalysis: UITextField!
    @IBOutlet weak var resultsPHAnalysis: UITextField!
    @IBOutlet weak var resultsAlkalinityAnalysis: UITextField!
    @IBOutlet weak var resultsCalciumAnalysis: UITextField!
    @IBOutlet weak var resultsCyanuricAcidAnalysis: UITextField!
    @IBOutlet weak var resultsAnalysisReport: UITextView!
    
    
    
    var toPassITT = String()
    var toPassFT = String()
    var toPass = String()
    var toPassFC = String()
    var toPassCC = String()
    var toPassPH = String()
    var toPassA = String()
    var toPassC = String()
    var toPassCA = String()
    
    let dateFormatter = DateFormatter()
    
    
    var FreeChlorine:Int = 0
    var TotalChlorine:Int = 0
    var CyanuricAcid:Int = 0
    
    
    var TF = Double()
    var Temp = 0.0
    var CF = Double()
    var Calcium = 0.0
    var AF = Double()
    var Alkalinity = 0.0
    var SaturationIndex = 0.0
    var PH = 0.0
    var RSIA = 0.0
    var resultsTC = 0.0
    var resultsFC = 0.0
    var resultsAPH = 0.0
    var resultsAlk = 0.0
    var resultsCal = 0.0
    var resultsCA = 0.0
    var resultsSI = 0.0
    
    var lowPH = 0.0
    var highPH = 0.0
    
    var totalAlkFactor = 0.0
    
    var clickFCResults = String()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true);
        
        resultsTemp.text = toPassFT
        resultsFreeChlorine.text = toPassFC
        resultsTotalChlorine.text = toPassCC
        resultsPH.text = toPassPH
        resultsAlkalinity.text = toPassA
        resultsCalcium.text = toPassC
        resultsCyanuricAcid.text = toPassCA
        
        // Test for Farenheit or Celsius, convert if Celsius to calculate Saturation Index
        if toPassITT != "Farenheit" {
            Temp = (Double(toPass)! * 1.8) + 32
            
        }
        else {
            Temp = Double(toPass)!
        }
        
        if Temp < 36 { TF = 0.0 }
        else if Temp > 36 && Temp < 46 { TF = 0.1 }
        else if Temp > 45 && Temp < 53 { TF = 0.2 }
        else if Temp > 52 && Temp < 60 { TF = 0.3 }
        else if Temp > 59 && Temp < 66 { TF = 0.4 }
        else if Temp > 65 && Temp < 76 { TF = 0.5 }
        else if Temp > 75 && Temp < 84 { TF = 0.6 }
        else if Temp > 83 && Temp < 94 { TF = 0.7 }
        else if Temp > 93 && Temp < 105 { TF = 0.8 }
        else { TF = 0.9 }
        
    
        Calcium = Double(toPassC)!
        if Calcium < 26 { CF = 1.0 }
        else if Calcium > 25 && Calcium < 51 { CF = 1.3 }
        else if Calcium > 50 && Calcium < 76 { CF = 1.5 }
        else if Calcium > 75 && Calcium < 101 { CF = 1.6 }
        else if Calcium > 100 && Calcium < 126 { CF = 1.7 }
        else if Calcium > 125 && Calcium < 151 { CF = 1.8 }
        else if Calcium > 150 && Calcium < 201 { CF = 1.9 }
        else if Calcium > 200 && Calcium < 251 { CF = 2.0 }
        else if Calcium > 250 && Calcium < 301 { CF = 2.1 }
        else if Calcium > 300 && Calcium < 401 { CF = 2.2 }
        else { CF = 2.5 }
        
        
        Alkalinity = Double(toPassA)!
        if Alkalinity < 26 { CF = 1.4 }
        else if Alkalinity > 25 && Alkalinity < 51 { AF = 1.7 }
        else if Alkalinity > 50 && Alkalinity < 76 { AF = 1.9 }
        else if Alkalinity > 75 && Alkalinity < 101 { AF = 2.0 }
        else if Alkalinity > 100 && Alkalinity < 126 { AF = 2.1 }
        else if Alkalinity > 125 && Alkalinity < 151 { AF = 2.2 }
        else if Alkalinity > 150 && Alkalinity < 201 { AF = 2.3 }
        else if Alkalinity > 200 && Alkalinity < 251 { AF = 2.4 }
        else if Alkalinity > 250 && Alkalinity < 301 { AF = 2.5 }
        else if Alkalinity > 300 && Alkalinity < 401 { AF = 2.6 }
        else { AF = 2.9 }

        
        
        
        PH = Double(toPassPH)!
        
        SaturationIndex = (PH + TF + CF + AF) - 12.1
        
        
        
        
        //to desplay saturation index on Results Page
        self.resultsSaturationIndex.text = String(format: "%.1f", SaturationIndex)
        
        
        //: To display the Analysis results on Results Page
        
        //:Free Chlorine
        resultsFC = Double(toPassFC)!
        if resultsFC > 0.5 && resultsFC < 3.5 { resultsFCAnalysis.inRange()
        } else { resultsFCAnalysis.adjustmentNeeded() }
        
        //:Combined Chlorine
        resultsTC = Double(toPassCC)!
        if resultsTC > -0.9 && resultsTC < 0.6 { resultsTCAnalysis.inRange()
        } else { resultsTCAnalysis.adjustmentNeeded() }
        
        //:PH
        resultsAPH = Double(toPassPH)!
        if resultsAPH > 7.1 && resultsAPH < 7.9 { resultsPHAnalysis.inRange()
        } else { resultsPHAnalysis.adjustmentNeeded() }
        
        //:Alkalinity
        resultsAlk = Double(toPassA)!
        if resultsAlk > 79.0 && resultsAlk < 121.0 { resultsAlkalinityAnalysis.inRange()
        } else { resultsAlkalinityAnalysis.adjustmentNeeded() }
        
        //: Calcium
        resultsCal = Double(toPassC)!
        if resultsCal > 149.0 && resultsCal < 501.0 { resultsCalciumAnalysis.inRange()
        } else { resultsCalciumAnalysis.adjustmentNeeded() }
        
        //: Cyanuric Acid
        resultsCA = Double(toPassCA)!
        if resultsCA > 19.0 && resultsCA < 51.0 { resultsCyanuricAcidAnalysis.inRange()
        } else { resultsCyanuricAcidAnalysis.adjustmentNeeded() }
        
        //: Saturation Index
        if SaturationIndex > -0.51 && SaturationIndex < 0.51 { resultsSIAnalysis.inRange()
        } else { resultsSIAnalysis.adjustmentNeeded() }
        
        
        
        //:self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        
        
    }
    @IBAction func clickFC(_ sender: Any) {
        if resultsFC > 0.5 && resultsFC < 3.5 { self.resultsAnalysisReport.text = String(format: "Free Chlorine is good no adjustment needed", resultsFC)
        } else
        { self.resultsAnalysisReport.text = "Add \(resultsFC * 10) Of Chlorine Shock"
          
        }
    }
    @IBAction func clickCC(_ sender: Any) {
        if resultsTC > -0.9 && resultsTC < 0.6 { self.resultsAnalysisReport.text = String(format: "Total Chlorine is good no adjustment needed", resultsTC)
        } else
        { self.resultsAnalysisReport.text = "Add \(resultsTC * 10) Of Chlorine Shock"
        
        }
    }
    @IBAction func clickPH(_ sender: Any) {
        
        if resultsAPH > 7.1 && resultsAPH < 7.9 { self.resultsAnalysisReport.text = String(format: "PH is good no adjustment needed", resultsAPH)
        }
        else if resultsAPH < 7.2 {
            let lowPH = 7.2 - resultsAPH
            self.resultsAnalysisReport.text = "PH is low add \(lowPH)lbs of Soda Ash"
        } else
        {
            let highPH = resultsAPH - 7.8
            self.resultsAnalysisReport.text = "PH is high add \(highPH)oz's Of Muriatic Acid"
        }
        
    }
    @IBAction func clickAlk(_ sender: Any) {
        if resultsAlk > 79.9 && resultsAlk < 121 { self.resultsAnalysisReport.text = String(format: "Alkatinity is good no adjustment needed", resultsAlk)
        }
        else if resultsAlk < 80.0 {
            let lowALK = 80.0 - resultsAlk
            self.resultsAnalysisReport.text = "Alkatinity is low add, \(lowALK)Oz's of Sodium Bicarbonate"
        } else
        {
            let highALK = resultsAlk - 120
            self.resultsAnalysisReport.text = "Alkatinity is high, drain \(highALK)% of pool water and refill with fresh water"
        }
        
    }
    @IBAction func clickCalcium(_ sender: Any) {
        if resultsCal > 149.0 && resultsCal < 501.0 { self.resultsAnalysisReport.text = String(format: "Alkatinity is good no adjustment needed", resultsCal)
        }
        else if resultsCal < 150.0 {
            let lowCAL = 150.0 - resultsCal
            self.resultsAnalysisReport.text = "Calcium is low add, \(lowCAL)Oz's of Sodium Bicarbonate"
        } else
        {
            let highCAL = resultsCal - 500.0
            self.resultsAnalysisReport.text = "Calcium is high, drain \(highCAL)% of pool water and refill with fresh water"
        }
        
    }
    @IBAction func clickCyanuricAcid(_ sender: Any) {
        if resultsCA > 19.0 && resultsCA < 51.0 { self.resultsAnalysisReport.text = String(format: "Cyanuric Acid is good no adjustment needed", resultsCA)
        }
        else if resultsCA < 50.0 {
            let lowCA = 50.0 - resultsCA
            self.resultsAnalysisReport.text = "Cyanuric Acid is low add, \(lowCA)Oz's of Stabulizer"
        } else
        {
            let highCA = resultsCA - 50.0
            self.resultsAnalysisReport.text = "Cyanuric Acid is high, drain \(highCA)% of pool water and refill with fresh water"
        }
        
    }
    @IBAction func clickSaturationIndex(_ sender: Any) {
        if SaturationIndex > -0.51 && SaturationIndex < 0.51 { self.resultsAnalysisReport.text = String(format: "Saturation Index is good no adjustment needed", String(format: "%.2f",SaturationIndex))
        }
        else if SaturationIndex < -0.50 {
            let lowSI = -0.50 - SaturationIndex
            self.resultsAnalysisReport.text = "Saturation Index is low add, \(String(format: "%.2f", lowSI))Oz's of Stabulizer"
        } else
        {
            let highSI = SaturationIndex - 0.50
            self.resultsAnalysisReport.text = "Saturation Index is high, drain \(String(format: "%.2f", highSI))% of pool water and refill with fresh water"
        }
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func updateLabel() -> Void {
        resultsDate.text = dateFormatter.string(from: Date());
        
        
        
    }
    
//MARK: Total Alkalinity Factor
    
//    func totalAlkalinityFactor(resultsAlk: UITextField) {
//
//        var resultsAlkFactor: Double? = Double(resultsAlk.text!)
//
//        if resultsAlkFactor >= 0.0 && resultsAlkFactor < 6.0 { let totalAlkFactor = 0.7
//        } else if resultsAlkFactor < 26 {
//            let totalAlkFactor = 1.4
//        } else if resultsAlkFactor < 51 {
//            let totalAlkFactor = 1.7
//        } else if resultsAlkFactor < 76 {
//            let totalAlkFactor = 1.9
//        } else if resultsAlkFactor < 101 {
//            let totalAlkFactor = 2.0
//        } else if resultsAlkFactor =< 126 {
//            let totalAlkFactor = 2.1
//        } else if resultsAlkFactor < 151 {
//            let totalAlkFactor = 2.2
//        } else if resultsAlkFactor < 201 {
//            let totalAlkFactor = 2.3
//        } else if resultsAlkFactor < 251 {
//            let totalAlkFactor = 2.4
//        } else if resultsAlkFactor < 301 {
//            let totalAlkFactor = 2.5
//        } else if resultsAlkFactor < 401 {
//            let totalAlkFactor = 2.6
//        } else if resultsAlkFactor < 801 {
//            let totalAlkFactor = 2.9
//        } else { let totalAlkFactor = 3.0
//        }
//
    
    
}

extension UITextField {
    func inRange() {
        self.text = "In Range"
        self.textAlignment = NSTextAlignment.center
        self.textColor = UIColor.black
        self.backgroundColor = UIColor.green
        self.frame.size = CGSize(width: 75, height: 25)
        self.layer.cornerRadius = 15
        //self.layer.cornerRadius = self.frame.height / 2
        //self.setTitleColor(UIColor.white, for: .normal)
        //self.layer.shadowColor = UIColor(red: 0, green: 0.1922, blue: 0.8392, alpha: 1).cgColor
        //self.layer.shadowRadius = 3
        //self.layer.shadowOpacity = 1.0
        //self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}

extension UITextField {
    func adjustmentNeeded() {
        self.text = "Out of Range"
        self.textAlignment = NSTextAlignment.center
        self.textColor = UIColor.black
        self.backgroundColor = UIColor.red
        self.frame.size = CGSize(width: 75, height: 25)
        self.layer.cornerRadius = 15
        
        
    }
}










