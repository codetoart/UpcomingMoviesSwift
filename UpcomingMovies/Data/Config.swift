//
//  Config.swift
//  UpcomingMovies
//
//  Created by Mahavir Jain on 13/10/16.
//  Copyright © 2016 CodeToArt. All rights reserved.
//

import Foundation

struct Config {
    
    var imageBaseURLString: String?
    var thumbSizeString: String?
    var largeSizestring: String?
    
    init(_ configDict: Dictionary<String, AnyObject?>) {
        if let baseString = configDict["secure_base_url"] as? String {
            self.imageBaseURLString = baseString
        }
        if let posterSizes = configDict["poster_sizes"] as? Array<String> {
            self.thumbSizeString = posterSizes.first
            self.largeSizestring = posterSizes.last
        }
    }
}
