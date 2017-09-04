//
//  ArticlesViewController.swift
//  LocalWikipedia
//
//  Created by Billybatigol on 04/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {
    
    var viewModel: ArticlesViewModel
    
    init(viewModel: ArticlesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ArticlesViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
