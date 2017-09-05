//
//  AppNavigationController.swift
//  LocalWikipedia
//
//  Created by Vasileios Loumanis on 04/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import UIKit
import SafariServices

class AppNavigationController {
    
    static let sharedInstance = AppNavigationController()
    
    lazy var navigationController: UINavigationController = {
        let articlesVC = ArticlesViewController(viewModel: ArticlesViewModel())
        articlesVC.controllerOutput = self
        return UINavigationController(rootViewController: articlesVC)
    }()
}

extension AppNavigationController: ArticlesViewControllerOutput {
    func didSelectRowAction(sender: UIViewController, selectedArticle: Article) {
        guard let url = URL(string: UrlStrings.baseMobileUrl + UrlStrings.pageUrl + String(selectedArticle.pageId)) else {
            (sender as? ArticlesViewController)?.handle(error: AppError.urlMissing)
            return
        }
        let safariVC = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        safariVC.title = selectedArticle.title
        navigationController.pushViewController(safariVC, animated: true)
    }
}
