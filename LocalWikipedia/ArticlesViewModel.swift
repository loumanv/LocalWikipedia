//
//  ArticlesViewModel.swift
//  LocalWikipedia
//
//  Created by Vasileios Loumanis on 04/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import UIKit
import CoreLocation

protocol ArticlesViewModelOutput {
    func updateTable()
    func handle(error: AppError)
    func isPerformingRequest(_: Bool)
}

class ArticlesViewModel: NSObject {
    
    var articles: [Article]?
    var controllerOutput: ArticlesViewModelOutput?
    let networkClient = NetworkClient.shared
    var locationManager: CLLocationManager?
    var searchLocation: CLLocation?
    var currentLocation: CLLocation?
    
    let sectionTitle = "Articles"
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.activityType = .fitness
    }
    
    func loadArticles() {
        controllerOutput?.isPerformingRequest(true)
        guard let searchLocation = searchLocation else {
            self.controllerOutput?.handle(error: AppError.locationNotAvailable)
            return
        }
        networkClient.loadArticles(location: searchLocation) { [weak self] (data, error) in
            
            self?.controllerOutput?.isPerformingRequest(false)
            guard error == nil,
                let data = data,
                let json = data as? [String: Any] else {
                    if let error = error {
                        self?.controllerOutput?.handle(error: error as! AppError)
                    }
                    self?.controllerOutput?.handle(error: NetworkClientError.jsonResponseEmpty)
                    return
            }
            
            let articles = Article.parseArticles(json: json)
            self?.articles = articles
            self?.controllerOutput?.updateTable()
        }
    }
    
    func articleTitleFor(row: Int) -> String {
        guard let article = articles?[row] else { return ""}
        return article.title
    }
    
    func articleDistanceFor(row: Int) -> String {
        guard let article = articles?[row] else { return ""}
        guard let distanceInMeters = currentLocation?.distance(from: CLLocation(latitude: article.latitude, longitude: article.longitude)) else { return "Not available" }
        return "\(Int(distanceInMeters)) meters away"
    }

    func updateWith(locations: [CLLocation]) {
        guard searchLocation != nil else {
            searchLocation = locations.first
            loadArticles()
            return
        }
        guard let current = locations.first, let distanceInMeters = searchLocation?.distance(from: current)  else { return }
        currentLocation = current
        if distanceInMeters > 20.0 {
            searchLocation = current
            loadArticles()
        } else {
            // This is not ideal but there doesn't seem to be a performance penalty for reloading the table. Further investigation
            // would be needed to test different approaches to this.
            controllerOutput?.updateTable()
        }
    }
}

extension ArticlesViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.updateWith(locations: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if error._code == CLError.denied.rawValue {
            controllerOutput?.handle(error: AppError.locationNotAuthorised)
        }
    }
}
