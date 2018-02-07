//
//  FontHelper.swift
//  UpcomingMovies
//
//  Created by Mahavir Jain on 13/10/16.
//  Copyright © 2016 CodeToArt. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    class func regularFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Regular", size: size)!
    }
    
    class func mediumFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Medium", size: size)!
    }
    
    class func demiBoldFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-DemiBold", size: size)!
    }
    
    class func boldFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Bold", size: size)!
    }
    
}
