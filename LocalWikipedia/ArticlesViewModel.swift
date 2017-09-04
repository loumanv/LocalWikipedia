//
//  ArticlesViewModel.swift
//  LocalWikipedia
//
//  Created by Vasileios Loumanis on 04/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import UIKit

protocol ArticlesViewModelOutput {
    func articlesFetched()
    func handle(error: Error)
    func isPerformingRequest(_: Bool)
}

class ArticlesViewModel {
    
    var articles: [Article]?
    var controllerOutput: ArticlesViewModelOutput?
    let networkClient = NetworkClient.shared
    
    let sectionTitle = "Articles"
    
    init() {
        loadArticles()
    }
    
    func loadArticles() {
        controllerOutput?.isPerformingRequest(true)
        guard let encoded = (Urls.baseUrl + Urls.articlesUrl).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encoded) else {
                controllerOutput?.handle(error: NetworkClientError.urlMissing)
                return
        }
        networkClient.load(url: url) { [weak self] (data, error) in
            
            self?.controllerOutput?.isPerformingRequest(false)
            guard error == nil,
                let data = data,
                let json = data as? [String: Any] else {
                    if let error = error {
                        self?.controllerOutput?.handle(error: error)
                    } else {
                        self?.controllerOutput?.handle(error: NetworkClientError.jsonResponseEmpty)
                    }
                    self?.controllerOutput?.handle(error: NetworkClientError.jsonResponseEmpty)
                    return
            }
            
            let articles = try? Article.parseArticles(json: json)
            self?.articles = articles
            self?.controllerOutput?.articlesFetched()
        }
    }
    
    func articleTitleFor(row: Int) -> String {
        guard let article = articles?[row] else { return ""}
        return article.title
    }
    
    func articleDistanceFor(row: Int) -> String {
        guard let article = articles?[row] else { return ""}
        return "\(article.distance) meters away"
    }
}
