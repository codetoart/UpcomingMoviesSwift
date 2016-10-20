//
//  MovieService.swift
//  UpcomingMovies
//
//  Created by Mahavir Jain on 10/10/16.
//  Copyright © 2016 CodeToArt. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol MovieServiceDelegate: class {
    func didReceiveMovies(movies: Array<Movie>)
    func didReceiveImages(backdropImages backdropImages: Array<MovieImage>, posterImages: Array<MovieImage>)
}

class MovieService {
    
    weak var delegate: MovieServiceDelegate?
    
    func fetchUpcomingMovies() {
        if let upcomingMovieURL = NSURL(string:  NetworkHelper.baseURLString + "/movie/upcoming") {
            let req = Alamofire.request(
                .GET,
                upcomingMovieURL,
                parameters:[
                    "api_key": NetworkHelper.apiKey
                ],
                headers: nil
                ).response { (request, response, data, error) in
                    
                    let json = JSON(data: data!)
                    if let movieResults = json["results"].arrayObject as? Array<Dictionary<String, AnyObject>> {
                        let movies = movieResults.map({Movie($0)})
                        self.delegate?.didReceiveMovies(movies)
                    }
                    
            }
            if NetworkHelper.printNetworkRequest() {
                print(req.debugDescription)
            }
        }
    }
    
    func fetchMovieImages(movieId: String) {
        if let movieImagesURL = NSURL(string:  NetworkHelper.baseURLString + "/movie/\(movieId)/images") {
            let req = Alamofire.request(
                .GET,
                movieImagesURL,
                parameters:[
                    "api_key": NetworkHelper.apiKey
                ],
                headers: nil
            ).response { (request, response, data, error) in
                    
                var backdropImages = Array<MovieImage>()
                var posterImages = Array<MovieImage>()
                
                let json = JSON(data: data!)
                if let backdropImageList = json["backdrops"].arrayObject as? Array<Dictionary<String, AnyObject>> {
                    for movieImageDict in backdropImageList{
                        backdropImages.append(MovieImage(movieImageDict))
                    }
                }
                if let posterImageList = json["posters"].arrayObject as? Array<Dictionary<String, AnyObject>> {
                    for movieImageDict in posterImageList{
                        posterImages.append(MovieImage(movieImageDict))
                    }
                }
                self.delegate?.didReceiveImages(backdropImages: backdropImages, posterImages: posterImages)
                    
            }
            if NetworkHelper.printNetworkRequest() {
                print(req.debugDescription)
            }
        }
    }
}
