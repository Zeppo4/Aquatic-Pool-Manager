//
//  SecondViewController.swift
//  Pool App 3.0
//
//  Created by Mac User on 11/6/16.
//  Copyright © 2016 Zeppo. All rights reserved.
//

import UIKit
import RealmSwift


var dropDownSelection = String()
var poolVolume = 0.0


class SecondViewController: UIViewController {
    
    let realm = try! Realm()
    var button = dropDownBtn()
    
    var poolNameArray = [String]()
    
    
    
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
    
    let dateFormatter = DateFormatter()
    
    var toPass = String()
    var toPassITT = String()
    var toPassFT = String()
    var toPassFC = String()
    var toPassCC = String()
    var toPassPH = String()
    var toPassA = String()
    var toPassC = String()
    var toPassCA = String()
    
    
    var TF = Double()
    var Temp = 0.0
    var CF = Double()
    var Calcium = 0.0
    var AF = Double()
    var Alkalinity = 0.0
    var SaturationIndex = 0.0
    var PH = 0.0
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
        
        if Temp < 40 { TF = 0.1 }
        else if Temp > 39 && Temp < 50 { TF = 0.2 }
        else if Temp > 49 && Temp < 56 { TF = 0.3 }
        else if Temp > 55 && Temp < 63 { TF = 0.4 }
        else if Temp > 62 && Temp < 70 { TF = 0.5 }
        else if Temp > 69 && Temp < 80 { TF = 0.6 }
        else if Temp > 79 && Temp < 86 { TF = 0.7 }
        else if Temp > 85 && Temp < 100 { TF = 0.8 }
        else if Temp > 99 && Temp < 115 { TF = 0.9 }
        else { TF = 1.0 }
        
    
        Calcium = Double(toPassC)!
        if Calcium < 26 { CF = 1.0 }
        else if Calcium > 19 && Calcium < 30 { CF = 1.0 }
        else if Calcium > 29 && Calcium < 39 { CF = 1.1 }
        else if Calcium > 38 && Calcium < 48 { CF = 1.2 }
        else if Calcium > 47 && Calcium < 59 { CF = 1.3 }
        else if Calcium > 58 && Calcium < 68 { CF = 1.4 }
        else if Calcium > 67 && Calcium < 86 { CF = 1.5 }
        else if Calcium > 85 && Calcium < 111 { CF = 1.6 }
        else if Calcium > 110 && Calcium < 136 { CF = 1.7 }
        else if Calcium > 135 && Calcium < 161 { CF = 1.8 }
        else if Calcium > 160 && Calcium < 221 { CF = 1.9 }
        else if Calcium > 220 && Calcium < 271 { CF = 2.0 }
        else if Calcium > 270 && Calcium < 326 { CF = 2.1 }
        else if Calcium > 325 && Calcium < 426 { CF = 2.2 }
        else if Calcium > 425 && Calcium < 526 { CF = 2.3 }
        else if Calcium > 525 && Calcium < 626 { CF = 2.4 }
        else if Calcium > 625 && Calcium < 851 { CF = 2.5 }
        else { CF = 2.6 }
        
        
        Alkalinity = Double(toPassA)!
        if Alkalinity < 38 { CF = 1.4 }
        else if Alkalinity > 37 && Alkalinity < 63 { AF = 1.7 }
        else if Alkalinity > 62 && Alkalinity < 88 { AF = 1.9 }
        else if Alkalinity > 87 && Alkalinity < 113 { AF = 2.0 }
        else if Alkalinity > 112 && Alkalinity < 138 { AF = 2.1 }
        else if Alkalinity > 137 && Alkalinity < 176 { AF = 2.2 }
        else if Alkalinity > 175 && Alkalinity < 226 { AF = 2.3 }
        else if Alkalinity > 225 && Alkalinity < 276 { AF = 2.4 }
        else if Alkalinity > 275 && Alkalinity < 351 { AF = 2.5 }
        else if Alkalinity > 350 && Alkalinity < 451 { AF = 2.6 }
        else if Alkalinity > 450 && Alkalinity < 551 { AF = 2.7 }
        else if Alkalinity > 550 && Alkalinity < 651 { AF = 2.8 }
        else { AF = 2.9 }

        PH = Double(toPassPH)!
        
        SaturationIndex = (PH + TF + CF + AF) - 12.1
        
        
        //to desplay saturation index on Results Page
        self.resultsSaturationIndex.text = String(format: "%.1f", SaturationIndex)
        
        
        //: To display the Analysis results on Results Page
        
        //MARK: - Free Chlorine
        resultsFC = Double(toPassFC)!
        if resultsFC > 0.5 && resultsFC < 10.1 { resultsFCAnalysis.inRange()
        } else { resultsFCAnalysis.adjustmentNeeded() }
        
        //:Combined Chlorine
        resultsTC = Double(toPassCC)!
        if resultsTC > -0.6 && resultsTC < 0.6 { resultsTCAnalysis.inRange()
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
        let poolName = realm.objects(PoolName.self)
        
        if poolName.isEmpty {
            button.setTitle("No Pools", for: .normal)
        } else {
            for pool in poolName {
                    poolNameArray.append(pool.name)
                //print(poolNameArray)
               
            }
            
        }
        
        button = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.setTitle("Select Pool", for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        
        //button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -200).isActive = true
        
        
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        button.dropView.dropDownOptions = poolNameArray
        
        
    }
    
    //MARK: - Free Chlorine Calculations
    
    @IBAction func clickFC(_ sender: Any) {
        if resultsFC > 0.5 && resultsFC < 3.5 { self.resultsAnalysisReport.text = String(format: "Free Chlorine is good no adjustment needed", resultsFC)
        } else {
            self.resultsAnalysisReport.text = "Add \(2 * (poolVolume / 10000) * (5 - resultsFC))oz Of Chlorine Shock, To rise the pool to 5ppm of chlorine. your Volume is \(poolVolume)"
          
        }
    }
    @IBAction func clickCC(_ sender: Any) {
        if resultsTC < 0.6  { self.resultsAnalysisReport.text = String(format: "Total Chlorine is good no adjustment needed", resultsTC)
        } else {
            let highCC = Double(round(10*(2.0 * (poolVolume / 10000) * ((resultsTC * 10)/16)))/10)
            self.resultsAnalysisReport.text = "Add \(highCC)lbs Of Chlorine Shock"
        
        }
    }
    
    //MARK: - PH Calculations
    
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
    
    //MARK: - Alkatinity Calculation
    
    @IBAction func clickAlk(_ sender: Any) {
        
        if resultsAlk > 79.9 && resultsAlk < 121 { self.resultsAnalysisReport.text = String(format: "Alkatinity is good no adjustment needed", resultsAlk)
        }
        else if resultsAlk < 80.0 {
            let lowALK = 80.0 - resultsAlk
            
            let alkAdjustment = Double(round(10*(1.4 * (poolVolume / 10000) * ((100 - lowALK)/10)))/10)
            
            self.resultsAnalysisReport.text = "Add \(alkAdjustment) lbs Of Sodium Bicarbonate, To rise the pool to 100ppm of Alkalinity. Your pool Volume is \(poolVolume)gal"
            
            
        } else
        {
            let highALK = Double(round(10*(2.1 * (poolVolume / 10000) * ((resultsAlk - 120)/10)))/10)
            self.resultsAnalysisReport.text = "Add \(highALK)lbs of Sodium Bisulfate, To lower the pool to 120ppm of Alkalinity. Your Pool Volume is \(poolVolume)gal"
        }
        
    }
    
    //MARK: - Calcium Calculation
    
    @IBAction func clickCalcium(_ sender: Any) {
        if resultsCal > 149.0 && resultsCal < 501.0 { self.resultsAnalysisReport.text = String(format: "Calcium is good no adjustment needed", resultsCal)
        }
        else if resultsCal < 150.0 {
            let lowCAL = Double(round(10*(1.2 * (poolVolume / 10000) * ((300 - resultsCal)/10)))/10)
            self.resultsAnalysisReport.text = "Add, \(lowCAL)lbs of Calcium Chloride, To rise the pool to 300ppm of Calcium. Your pool Volume is \(poolVolume)gal"
        } else
        {
            
            self.resultsAnalysisReport.text = "Calcium is high, drain 1/3 of pool water and refill with fresh water and retest the next day"
        }
        
    }
    
    //MARK: - Cyanuric Acid Calculation
    
    @IBAction func clickCyanuricAcid(_ sender: Any) {
        if resultsCA > 19.0 && resultsCA < 101.0 { self.resultsAnalysisReport.text = String(format: "Cyanuric Acid is good no adjustment needed", resultsCA)
        }
        else if resultsCA < 30.0 {
            let lowCA = Double(round(10*(0.81 * (poolVolume / 10000) * ((50 - resultsCA)/10)))/10)
            self.resultsAnalysisReport.text = "Add, \(lowCA)Oz's of Stabulizer or Cyanuric Acid, To rise the pool to 50ppm of Cyanuric Acid. Your pool Volume is \(poolVolume)gal"
        } else
        {
            
            self.resultsAnalysisReport.text = "Stabulizer is high. Ideal is 30 - 50 with a max of 100 yours is \(resultsCA). Drain 1/3 of pool water and refill with fresh water and retest the next day. Repeat this until your readings are below 100"
        }
        
    }
    
    //MARK: - Saturation Index Calculation
    
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
    
    
    //MARK: - Drop Down Button
    
    class dropDownBtn: UIButton, dropDownProtocol {
        
        func dropDownPressed(string: String) {
            self.setTitle(string, for: .normal)
            self.dismissDropDown()
        }
        
        
        var dropView = dropDownView()
        
        var height = NSLayoutConstraint()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            //self.backgroundColor = UIColor.green
            
            self.backgroundColor = UIColor.darkText
            self.layer.cornerRadius = 15
            dropView = dropDownView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
            dropView.delegate = self
            dropView.translatesAutoresizingMaskIntoConstraints = false
           
        }
        
        override func didMoveToSuperview() {
            self.superview?.addSubview(dropView)
            self.superview?.bringSubview(toFront: dropView)
            dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            height = dropView.heightAnchor.constraint(equalToConstant: 0)
        }
        var isOpen = false
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if isOpen == false {
                
                isOpen = true
                
                NSLayoutConstraint.deactivate([self.height])
                
               if self.dropView.tableView.contentSize.height > 150 {
                self.height.constant = 150
                } else {
                    self.height.constant = self.dropView.tableView.contentSize.height
                }
                
                NSLayoutConstraint.activate([self.height])
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    self.dropView.layoutIfNeeded()
                    self.dropView.center.y += self.dropView.frame.height / 2
                }, completion: nil)
                
                
            } else {
                isOpen = false
                
                NSLayoutConstraint.deactivate([self.height])
                self.height.constant = 0
                NSLayoutConstraint.activate([self.height])
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    self.dropView.center.y -= self.dropView.frame.height / 2
                    self.dropView.layoutIfNeeded()
                }, completion: nil)
            }
        }
        
        func dismissDropDown() {
            isOpen = false
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()
            }, completion: nil)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    //MARK: - Class dropDownView
    
    class dropDownView: UIView, UITableViewDelegate, UITableViewDataSource {
        
        var dropDownOptions = [String]()
        
        var tableView = UITableView()
        
        var delegate : dropDownProtocol!
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            tableView.backgroundColor = UIColor.darkGray
            self.backgroundColor = UIColor.darkGray
            
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(tableView)
            
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dropDownOptions.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = UITableViewCell()
            
            cell.textLabel?.text = dropDownOptions[indexPath.row]
            cell.backgroundColor = UIColor.darkGray
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            self.delegate.dropDownPressed(string: dropDownOptions[indexPath.row])
            let dropDownSelection = dropDownOptions[indexPath.row]
            
            
            poolSelected(dropDownSelection: dropDownSelection)
            
            self.tableView.deselectRow(at: indexPath, animated: true)
            
        }
    }
    
    
    //MARK: - End of SecondViewController Class
}
func poolSelected(dropDownSelection: String) {
    
    let realm = try! Realm()
    let poolName = realm.objects(PoolName.self)
    
    for pool in poolName {
        if pool.name == dropDownSelection {
            poolVolume = pool.volume
            
            break
        }
        
    }
}


protocol dropDownProtocol {
    func dropDownPressed(string: String)
}

extension UITextField {
    func inRange() {
        self.text = "In Range"
        self.textAlignment = NSTextAlignment.center
        self.textColor = UIColor.black
        self.backgroundColor = UIColor.green
        self.frame.size = CGSize(width: 75, height: 25)
        self.layer.cornerRadius = 15
        
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










