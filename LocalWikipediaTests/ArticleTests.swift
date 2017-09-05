//
//  ArticleTests.swift
//  ArticleTests
//
//  Created by Vasileios Loumanis on 04/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import LocalWikipedia

class ArticleTests: XCTestCase {
    
    var dictionary: [String: Any]?
    var article: Article?
    var articles: [Article]?

    func createArticle() {

        dictionary = [
            "pageid":14931082,
            "ns":0,
            "title":"One Blackfriars",
            "lat":51.507801,
            "lon":-0.10473,
            "dist":129.7,
            "primary":""
        ]
        article = try? Article(dictionary: dictionary!)
    }

    func createArticles() {
        let fileURL = Bundle(for: type(of: self)).url(forResource: "articles", withExtension: "json")!
        let	data = try! Data(contentsOf: fileURL)
        let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
        articles = Article.parseArticles(json: dictionary)
    }
    
    func testArticleInitializationSucceeds() {
        createArticle()
        XCTAssertNotNil(article)
    }
    
    func testArticleJsonParseSucceeds() {
        createArticle()
        XCTAssertEqual(article?.pageId, 14931082)
        XCTAssertEqual(article?.title, "One Blackfriars")
        XCTAssertEqual(article?.latitude, 51.507801)
        XCTAssertEqual(article?.longitude, -0.10473)
        XCTAssertEqual(article?.distance, 129.7)
    }

    func testArticlesInitializationSucceeds() {
        createArticles()
        XCTAssertNotNil(articles)
    }

    func testArticlesJsonParseSucceeds() {
        createArticles()
        XCTAssertEqual(articles?.count, 10)
    }
}
