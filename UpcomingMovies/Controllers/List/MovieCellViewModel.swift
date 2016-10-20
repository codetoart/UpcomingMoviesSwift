//
//  MovieCellViewModel.swift
//  UpcomingMovies
//
//  Created by Mahavir Jain on 13/10/16.
//  Copyright © 2016 CodeToArt. All rights reserved.
//

import Foundation

class MovieCellViewModel {
    
    var movie: Movie?
    
    convenience init(_ movie: Movie) {
        self.init()
        self.movie = movie
    }
    
    func getMovieTitle() -> String? {
        return self.movie?.title
    }
    
    func getImageURL() -> NSURL? {
        return self.movie?.posterThumbURL
    }
    
    func formattedReleaseDate() -> String {
        var rdString = ""
        if let rd = self.movie?.releaseDate {
            let df = NSDateFormatter()
            df.dateFormat = "dd MMM, yyyy"
            rdString = df.stringFromDate(rd)
        }
        
        return rdString
    }
}
