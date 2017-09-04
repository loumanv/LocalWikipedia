//
//  Article.swift
//  LocalWikipedia
//
//  Created by Billybatigol on 04/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import Foundation
import CoreLocation

class Article {
    
    enum ArticleError: LocalizedError {
        case pageId
        case missingTitle
        case missingLatitude
        case missingLongitude
        case missingDistance
    }
    
    var pageId: Int
    var title: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var distance: Double

    
    init(dictionary: [String: Any]) throws {
        
        guard let pageId = dictionary["pageid"] as? Int else { throw ArticleError.pageId}
        guard let title = dictionary["title"] as? String else { throw ArticleError.missingTitle}
        guard let latitude = dictionary["lat"] as? CLLocationDegrees else { throw ArticleError.missingLatitude}
        guard let longitude = dictionary["lon"] as? CLLocationDegrees else { throw ArticleError.missingLongitude}
        guard let distance = dictionary["dist"] as? Double else { throw ArticleError.missingDistance}
        
        self.pageId = pageId
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.distance = distance
    }
}