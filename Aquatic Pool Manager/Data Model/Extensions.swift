//
//  Extensions.swift
//  
//
//  Created by Mac User on 5/6/18.
//

import Foundation
import UIKit



extension UIColor {
    
    static let universalBlue = UIColor().colorFromHex("85F6FF")
    static let terraCotta = UIColor().colorFromHex("E66B5B")
    static let sand = UIColor().colorFromHex("FAEDD1")
    static let oceanBlue = UIColor().colorFromHex("0E34FA")
    static let grassGreen = UIColor().colorFromHex("008040")
    
    
    func colorFromHex(_ hex : String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            return UIColor.black
        }
        
        var rgb : UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                            blue: CGFloat(rgb & 0x0000FF) / 255.0,
                            alpha: 1.0)
        
    }
}
