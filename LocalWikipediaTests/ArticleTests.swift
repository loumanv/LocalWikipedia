//
//  ArticleTests.swift
//  ArticleTests
//
//  Created by Billybatigol on 04/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import LocalWikipedia

class ArticleTests: XCTestCase {
    
    var dictionary: [String: Any]?
    var article: Article?
    
    override func setUp() {
        super.setUp()

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
    
    func testArticleInitializationSucceeds() {
        XCTAssertNotNil(article)
    }
    
    func testArticleJsonParseSucceeds() {
        XCTAssertEqual(article?.pageId, 14931082)
        XCTAssertEqual(article?.title, "One Blackfriars")
        XCTAssertEqual(article?.latitude, 51.507801)
        XCTAssertEqual(article?.longitude, -0.10473)
        XCTAssertEqual(article?.distance, 129.7)
    }
}
