//
//  MovieImage.swift
//  UpcomingMovies
//
//  Created by Mahavir Jain on 13/10/16.
//  Copyright © 2016 CodeToArt. All rights reserved.
//

import Foundation

struct MovieImage {
    
    var aspectRatio: Float?
    var path: String?
    var voteAvg: Float?
    var voteCount: Int?
    
    init(_ movieImageDict: Dictionary<String, AnyObject?>) {
        if let aspectRatio = movieImageDict["aspect_ratio"] as? Float {
            self.aspectRatio = aspectRatio
        }
        if let path = movieImageDict["file_path"] as? String {
            self.path = path
        }
        if let voteAvg = movieImageDict["vote_average"] as? Float {
            self.voteAvg = voteAvg
        }
        if let voteCount = movieImageDict["vote_count"] as? Int {
            self.voteCount = voteCount
        }
    }
}
