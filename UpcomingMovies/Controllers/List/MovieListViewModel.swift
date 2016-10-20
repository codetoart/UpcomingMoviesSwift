//
//  MovieListViewModel.swift
//  UpcomingMovies
//
//  Created by Mahavir Jain on 13/10/16.
//  Copyright © 2016 CodeToArt. All rights reserved.
//

import Foundation

class MovieListViewModel {
    
    weak var vc: MovieListController?
    
    private var movies = Array<Movie>()
    private var selectedMovie: Movie?
    
    func getMovies() {
        let ms = MovieService()
        ms.delegate = self
        ms.fetchUpcomingMovies()
    }
    
    func movieCount() -> Int {
        return self.movies.count
    }
    
    func getMovieCellViewModel(index: Int) -> MovieCellViewModel {
        let movie = self.movies[index]
        return MovieCellViewModel(movie)
    }
    
    func selectMovieAtIndex(index: Int) {
        self.selectedMovie = self.movies[index]
    }
    
    func getSelectedMovie() -> Movie? {
        return selectedMovie
    }
}

extension MovieListViewModel: MovieServiceDelegate {
    
    func didReceiveMovies(movies: Array<Movie>) {
        self.movies = movies
        self.vc?.updateViews()
    }
    
    func didReceiveImages(backdropImages backdropImages: Array<MovieImage>, posterImages: Array<MovieImage>) {
        
    }
    
}
