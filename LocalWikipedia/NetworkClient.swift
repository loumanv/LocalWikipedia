//
//  NetworkClient.swift
//  LocalWikipedia
//
//  Created by Vasileios Loumanis on 04/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import Alamofire
import CoreLocation

struct UrlStrings {
    static let baseUrl = "https://en.wikipedia.org"
    static var parameters = ["action": "query", "list": "geosearch", "format": "json"]
    static let articlesUrl = "/w/api.php"
    static let coordinatesKey = "gscoord"
}

enum NetworkClientError: LocalizedError {
    case urlMissing
    case connection
    case jsonResponseEmpty
}

class NetworkClient {
    
    public static let shared = NetworkClient()
    
    func load(urlString: String, parameters: [String: String]?, completion: @escaping ((Any?, Error?) -> Void)) {
        Alamofire.request(urlString, parameters: parameters).responseJSON { response in
            
            switch response.result {
            case .success(let data):
                completion(data, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func loadArticles(location: CLLocation, completion: @escaping ((Any?, Error?) -> Void)) {
        var parameters = UrlStrings.parameters
        parameters[UrlStrings.coordinatesKey] = "\(location.coordinate.latitude)|\(location.coordinate.longitude)"
        load(urlString: UrlStrings.baseUrl + UrlStrings.articlesUrl, parameters: parameters, completion: completion)
    }
}


