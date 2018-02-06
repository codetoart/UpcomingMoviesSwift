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
    
    class func saveConfig(_ config: Config) {
        if let ad = UIApplication.shared.delegate as? AppDelegate {
            ad.config = config
        }
    }
    
    class func getConfig() -> Config? {
        var config: Config?
        if let ad = UIApplication.shared.delegate as? AppDelegate {
            config = ad.config
        }
        
        return config
    }
    
    class func getMovieLargeURLFromPath(_ path: String) -> URL? {
        var fileURL: URL?
        if let basePath = AppHelper.getConfig()?.imageBaseURLString, let largeSize = AppHelper.getConfig()?.largeSizestring {
            let fullPath = basePath + largeSize + path
            fileURL = URL(string: fullPath)
        }
        
        return fileURL
    }
    
    class func getMovieThumbURLFromPath(_ path: String) -> URL? {
        var fileURL: URL?
        if let basePath = AppHelper.getConfig()?.imageBaseURLString, let thumbSize = AppHelper.getConfig()?.thumbSizeString {
            let fullPath = basePath + thumbSize + path
            fileURL = URL(string: fullPath)
        }
        
        return fileURL
    }
    
    class func dateFromServerString(_ dateStr: String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        return df.date(from: dateStr)
    }
}
