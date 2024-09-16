//
//  DealsVC.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 16/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Combine
import UIKit

class DealsVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var viewModel: DealsVM?
    var subscribers: Set<AnyCancellable> = []
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(
            style: .large
        )
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel?.getPageTitle() ?? "List"
        
        setupTableView()
        setupIndicatorView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(
            nibName: ProductItemTVC.reuseIdentifier,
            bundle: nil
        )
        tableView.register(
            nib,
            forCellReuseIdentifier: ProductItemTVC.reuseIdentifier
        )
        
        viewModel?
            .$products
            .receive(
                on: DispatchQueue.main
            )
            .sink(receiveValue: {
                [weak self] _ in
                if !(
                    self?.viewModel?.products.isEmpty ?? true
                ) {
                    self?.activityIndicator.stopAnimating()
                }
                self?.tableView.reloadData()
            })
            .store(
                in: &subscribers
            )
    }
    
    func setupIndicatorView() {
        view.addSubview(
            activityIndicator
        )
        
        activityIndicator.startAnimating()
        
        NSLayoutConstraint.activate(
            [
                activityIndicator.centerXAnchor.constraint(
                    equalTo: view.centerXAnchor
                ),
                activityIndicator.centerYAnchor.constraint(
                    equalTo: view.centerYAnchor
                )
            ]
        )
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension DealsVC: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel?.numberOfProducts() ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let product = viewModel?.getProduct(
                at: indexPath.row
            ),
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductItemTVC.reuseIdentifier,
                for: indexPath
            ) as? ProductItemTVC else {
            return UITableViewCell()
        }
        
        if let viewModel = viewModel, let product = viewModel.getProduct(
            at: indexPath.row
        ) {
            cell.configureFor(
                product: product
            )
        }
        
        return cell
    }
    
}

extension DealsVC: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(
            at: indexPath,
            animated: true
        )
        self.viewModel?.showDetailsForProduct(
            at: indexPath.row
        )
    }
    
}
