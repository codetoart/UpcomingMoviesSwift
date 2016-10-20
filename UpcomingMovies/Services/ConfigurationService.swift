//
//  ConfigurationService.swift
//  UpcomingMovies
//
//  Created by Mahavir Jain on 10/10/16.
//  Copyright © 2016 CodeToArt. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ConfigurationServiceDelegate: class {
    func didReceiveConfig(config: Config)
}

struct ConfigurationService {
    
    weak var delegate: ConfigurationServiceDelegate?
    
    func fetchConfig() {
        if let configURL = NSURL(string:  NetworkHelper.baseURLString + "/configuration") {
            let req = Alamofire.request(
                .GET,
                configURL,
                parameters:[
                    "api_key": NetworkHelper.apiKey
                ],
                headers: nil
            ).response { (request, response, data, error) in
                    
                let json = JSON(data: data!)
                if let imagesDict = json["images"].dictionaryObject {
                    let config = Config(imagesDict)
                    self.delegate?.didReceiveConfig(config)
                }
                    
            }
            if NetworkHelper.printNetworkRequest() {
                print(req.debugDescription)
            }
        }
    }
}
