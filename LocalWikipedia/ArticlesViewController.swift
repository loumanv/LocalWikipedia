//
//  ArticlesViewController.swift
//  LocalWikipedia
//
//  Created by Vasileios Loumanis on 04/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {
    
    var viewModel: ArticlesViewModel
    
    @IBOutlet weak var table: UITableView! {
        didSet {
            table.estimatedRowHeight = 44
            table.rowHeight = UITableViewAutomaticDimension
            
            table.register(UINib(nibName: String(describing: ArticleCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ArticleCell.self))
        }
    }
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
    
    init(viewModel: ArticlesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ArticlesViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.controllerOutput = self
        table.delegate = self
        table.dataSource = self
        addNavigationItems()
    }
    
    func reload() {
        viewModel.loadArticles()
    }
    
    func addNavigationItems() {
        let activityBarButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.rightBarButtonItem  = activityBarButton
        activityIndicator.startAnimating()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reload", style: .plain, target: self, action: #selector(reload))
    }
    
    func showErrorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension ArticlesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: String(describing: ArticleCell.self), for: indexPath) as? ArticleCell else { return UITableViewCell() }
        cell.titleLabel.text = viewModel.articleTitleFor(row: indexPath.row)
        cell.distanceLabel.text = viewModel.articleDistanceFor(row: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension ArticlesViewController: ArticlesViewModelOutput {
    func articlesFetched() {
        table.reloadData()
    }
    
    func handle(error: Error) {
        showErrorMessage(title: "An Error Occurred", message: error.localizedDescription)
    }
    
    func isPerformingRequest(_ isPerformingRequest: Bool) {
        isPerformingRequest ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}
