//
//  AppNavigationController.swift
//  LocalWikipedia
//
//  Created by Vasileios Loumanis on 04/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import UIKit

class AppNavigationController {
    
    static let sharedInstance = AppNavigationController()
    
    lazy var navigationController: UINavigationController = {
        let articlesVC = ArticlesViewController(viewModel: ArticlesViewModel())
        return UINavigationController(rootViewController: articlesVC)
    }()
}
