//
//  MovieDetailViewModel.swift
//  UpcomingMovies
//
//  Created by Mahavir Jain on 14/10/16.
//  Copyright © 2016 CodeToArt. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewModel {
    
    var movie: Movie?
    var images: Array<URL>?
    
    weak var movieDetailController: MovieDetailController?
    
    convenience init (_ movie: Movie, movieDetailController: MovieDetailController) {
        self.init()
        self.movie = movie
        self.movieDetailController = movieDetailController
    }
    
    func getMovieImages(){
        if let id = self.movie?.id {
            let ms = MovieService()
            ms.delegate = self
            ms.fetchMovieImages(id)
        }
    }
 
    func getTitle() -> String? {
        return self.movie?.title
    }
    
    func formattedReleaseDate() -> String {
        var rdString = ""
        if let rd = self.movie?.releaseDate {
            let df = DateFormatter()
            df.dateFormat = "dd MMM, yyyy"
            rdString = df.string(from: rd as Date)
        }
        
        return rdString
    }
    
    func getRating() -> Float? {
        return self.movie?.popularity
    }
    
    func getOverview() -> String? {
        return self.movie?.overview
    }
    
    func getDefaultCell() -> UITableViewCell {
        return UITableViewCell()
    }

}

extension MovieDetailViewModel: MovieServiceDelegate {
    func didReceiveMovies(_ movies: Array<Movie>) {
        
    }
    
    func didReceiveImages(backdropImages: Array<MovieImage>, posterImages: Array<MovieImage>) {
        self.images = posterImages.map{ AppHelper.getMovieLargeURLFromPath($0.path!)! }
        self.movieDetailController?.displayImages()
    }
}
