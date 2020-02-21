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
    func didReceiveMovies(_ movies: Array<Movie>)
    func didReceiveImages(backdropImages: Array<MovieImage>, posterImages: Array<MovieImage>)
}

class MovieService {

    weak var delegate: MovieServiceDelegate?

    func fetchUpcomingMovies() {
        if let upcomingMovieURL = URL(string:  NetworkHelper.baseURLString + "/movie/upcoming") {
            let req = Alamofire.request(
                upcomingMovieURL,
                method: .get,
                parameters:[
                    "api_key": NetworkHelper.apiKey
                ],
                headers: nil
                ).response { (response) in

                    let json = try! JSON(data: response.data!)
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

    func fetchMovieImages(_ movieId: String) {
        if let movieImagesURL = URL(string:  NetworkHelper.baseURLString + "/movie/\(movieId)/images") {
            let req = Alamofire.request(
                movieImagesURL,
                method: .get,
                parameters:[
                    "api_key": NetworkHelper.apiKey
                ],
                headers: nil
            ).response { (response) in

                var backdropImages = Array<MovieImage>()
                var posterImages = Array<MovieImage>()

                let json = try! JSON(data: response.data!)
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
