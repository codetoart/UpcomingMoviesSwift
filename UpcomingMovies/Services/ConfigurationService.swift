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
    func didReceiveConfig(_ config: Config)
}

struct ConfigurationService {

    weak var delegate: ConfigurationServiceDelegate?

    func fetchConfig() {
        if let configURL = URL(string:  NetworkHelper.baseURLString + "/configuration") {
            let req = Alamofire.request(
                configURL,
                method: .get,
                parameters:[
                    "api_key": NetworkHelper.apiKey
                ],
                headers: nil
            ).response { (response) in

                let json = try! JSON(data: response.data!)
                if let imagesDict = json["images"].dictionaryObject {
                    let config = Config(imagesDict as Dictionary<String, AnyObject?>)
                    self.delegate?.didReceiveConfig(config)
                }

            }
            if NetworkHelper.printNetworkRequest() {
                print(req.debugDescription)
            }
        }
    }
}
