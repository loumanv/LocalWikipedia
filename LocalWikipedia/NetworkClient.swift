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
    static var parameters = [
        "action": "query",
        "list": "geosearch",
        "format": "json"
    ]
    static let articlesUrl = "/w/api.php"
    static let coordinatesKey = "gscoord"
    static let baseMobileUrl = "https://en.m.wikipedia.org"
    static let pageUrl = "/?curid="
}

struct NetworkClientError {
    static let jsonResponseEmpty = AppError(localizedTitle: "JSON Response Empty", localizedDescription: "JSON Response Empty", code: 0)
}

class NetworkClient {
    
    public static let shared = NetworkClient()
    var receivingArticlesData: Bool = false
    
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
        guard receivingArticlesData == false else { return }
        var parameters = UrlStrings.parameters
        parameters[UrlStrings.coordinatesKey] = "\(location.coordinate.latitude)|\(location.coordinate.longitude)"
        receivingArticlesData = true
        load(urlString: UrlStrings.baseUrl + UrlStrings.articlesUrl, parameters:parameters) { [weak self] (data, error) in
            self?.receivingArticlesData = false
            completion(data, error)
        }
    }
}


