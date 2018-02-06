//
//  Movie.swift
//  UpcomingMovies
//
//  Created by Mahavir Jain on 10/10/16.
//  Copyright © 2016 CodeToArt. All rights reserved.
//

import Foundation

struct Movie {
    
    var id: String?
    var title: String?
    var originalTitle: String?
    var originalLanguage: String?
    var overview: String?
    var releaseDate: Date?
    var popularity: Float?
    var voteCount: Int?
    var voteAvg: Float?
    var adult: Bool = false
    var posterThumbURL: URL?
//    var backdropURL: NSURL?
    
    init(_ movieDict: Dictionary<String, AnyObject?>) {
        if let id = movieDict["id"] as? Int {
            self.id = "\(id)"
        }
        if let title = movieDict["title"] as? String {
            self.title = title
        }
        if let originalTitle = movieDict["original_title"] as? String {
            self.originalTitle = originalTitle
        }
        if let originalLanguage = movieDict["original_language"] as? String {
            self.originalLanguage = originalLanguage
        }
        if let overview = movieDict["overview"] as? String {
            self.overview = overview
        }
        if let releaseDateStr = movieDict["release_date"] as? String, let releaseDate = AppHelper.dateFromServerString(releaseDateStr) {
            self.releaseDate = releaseDate
        }
        if let popularity = movieDict["popularity"] as? Float {
            self.popularity = popularity
        }
        if let voteCount = movieDict["vote_count"] as? Int {
            self.voteCount = voteCount
        }
        if let voteAvg = movieDict["vote_average"] as? Float {
            self.voteAvg = voteAvg
        }
        if let adult = movieDict["adult"] as? Bool {
            self.adult = adult
        }
        if let posterPath = movieDict["poster_path"] as? String, let posterURL = AppHelper.getMovieThumbURLFromPath(posterPath) {
            self.posterThumbURL = posterURL
        }
//        if let backdropPath = movieDict["backdrop_path"] as? String, backdropURL = AppHelper.getURLFromPath(backdropPath) {
//            self.backdropURL = backdropURL
//        }
    }
}
