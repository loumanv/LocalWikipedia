//
//  NetworkClient.swift
//  LocalWikipedia
//
//  Created by Vasileios Loumanis on 04/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import Alamofire

struct Urls {
    static let baseUrl = "https://en.wikipedia.org"
    static let articlesUrl = "/w/api.php?action=query&list=geosearch&gsradius=10000&gscoord=51.508164|-0.106511&format=json"
}

enum NetworkClientError: LocalizedError {
    case urlMissing
    case connection
    case jsonResponseEmpty
}

class NetworkClient {
    
    public static let shared = NetworkClient()
    
    func load(url: URL, completion: @escaping ((Any?, Error?) -> Void)) {
        Alamofire.request(url).responseJSON { response in
            
            switch response.result {
            case .success(let data):
                completion(data, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}


