//
//  ColorHelper.swift
//  UpcomingMovies
//
//  Created by Mahavir Jain on 13/10/16.
//  Copyright © 2016 CodeToArt. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func primaryColor() -> UIColor {
        return UIColor.colorWithHexString("#D32F2F")
    }
    
    class func darkPrimaryColor() -> UIColor {
        return UIColor.colorWithHexString("#F44336")
    }
    
    class func lightPrimaryColor() -> UIColor {
        return UIColor.colorWithHexString("#FFCDD2")
    }
    
    class func lightColor() -> UIColor {
        return UIColor.colorWithHexString("#FFFFFF")
    }
    
    class func accentColor() -> UIColor {
        return UIColor.colorWithHexString("#536DFE")
    }
    
    class func primaryTextColor() -> UIColor {
        return UIColor.colorWithHexString("#212121")
    }
    
    class func secondaryTextColor() -> UIColor {
        return UIColor.colorWithHexString("#757575")
    }
    
    class func dividerColor() -> UIColor {
        return UIColor.colorWithHexString("#BDBDBD")
    }
    
    class func colorWithHexString (_ hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}
