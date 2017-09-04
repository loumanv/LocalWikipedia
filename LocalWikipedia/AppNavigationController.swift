//
//  AppNavigationController.swift
//  LocalWikipedia
//
//  Created by Billybatigol on 04/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import UIKit

class AppNavigationController {
    
    static let sharedInstance = AppNavigationController()
    
    lazy var navigationController: UINavigationController = {
        let auctionsVC = ArticlesViewController(viewModel: ArticlesViewModel())
        return UINavigationController(rootViewController: auctionsVC)
    }()
}
