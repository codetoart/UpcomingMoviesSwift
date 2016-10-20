//
//  AppHelper.swift
//  UpcomingMovies
//
//  Created by Mahavir Jain on 13/10/16.
//  Copyright © 2016 CodeToArt. All rights reserved.
//

import Foundation
import UIKit

class AppHelper {
    
    class func saveConfig(config: Config) {
        if let ad = UIApplication.sharedApplication().delegate as? AppDelegate {
            ad.config = config
        }
    }
    
    class func getConfig() -> Config? {
        var config: Config?
        if let ad = UIApplication.sharedApplication().delegate as? AppDelegate {
            config = ad.config
        }
        
        return config
    }
    
    class func getMovieLargeURLFromPath(path: String) -> NSURL? {
        var fileURL: NSURL?
        if let basePath = AppHelper.getConfig()?.imageBaseURLString, largeSize = AppHelper.getConfig()?.largeSizestring {
            let fullPath = basePath + largeSize + path
            fileURL = NSURL(string: fullPath)
        }
        
        return fileURL
    }
    
    class func getMovieThumbURLFromPath(path: String) -> NSURL? {
        var fileURL: NSURL?
        if let basePath = AppHelper.getConfig()?.imageBaseURLString, thumbSize = AppHelper.getConfig()?.thumbSizeString {
            let fullPath = basePath + thumbSize + path
            fileURL = NSURL(string: fullPath)
        }
        
        return fileURL
    }
    
    class func dateFromServerString(dateStr: String) -> NSDate? {
        let df = NSDateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        return df.dateFromString(dateStr)
    }
}
