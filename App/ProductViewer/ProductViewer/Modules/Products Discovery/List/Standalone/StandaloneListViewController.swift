//
//  Copyright © 2022 Target. All rights reserved.
//

import UIKit

final class StandaloneListViewController: UIViewController {
    
    var viewModel: DealsVM?
    
    private lazy var layout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(220)
        )
        
        let item = NSCollectionLayoutItem(
            layoutSize: itemSize
        )
        
        item.edgeSpacing = .init(
            leading: nil,
            top: .fixed(8),
            trailing: nil,
            bottom: .fixed(8)
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(220)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(
            group: group
        )
        
        let layout = UICollectionViewCompositionalLayout(
            section: section
        )
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.backgroundColor = UIColor.background
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(
            StandaloneListItemViewCell.self,
            forCellWithReuseIdentifier: StandaloneListItemViewCell.reuseIdentifier
        )
        
        let nib = UINib(nibName: ProductItemCVC.reuseIdentifier, bundle: nil)
        collectionView.register(
            nib,
            forCellWithReuseIdentifier: ProductItemCVC.reuseIdentifier
        )
                
        return collectionView
    }()
    
//    private var sections: [ListSection] = [] {
//        didSet {
//            collectionView.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)

        collectionView.contentInset = UIEdgeInsets(
            top: 20.0,
            left: 0.0,
            bottom: 0.0,
            right: 0.0
        )
        
        title = viewModel?.getPageTitle() ?? "List"
        
        view.addAndPinSubview(collectionView)
        
//        sections = [
//            ListSection(
//                index: 1,
//                items: (1..<10).map { index in
//                    ListItem(
//                        title: "Puppies!!!",
//                        price: "$9.99",
//                        image: UIImage(named: "\(index)"),
//                        index: index
//                    )
//                }
//            ),
//        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.collectionView.reloadData()
        }
    }
}

extension StandaloneListViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        self.viewModel?.showDetailsForProduct(at: indexPath.row)
//        guard
//            sections.indices.contains(indexPath.section),
//            sections[indexPath.section].items.indices.contains(indexPath.row)
//        else {
//            return
//        }
//        
//        let productListItem = sections[indexPath.section].items[indexPath.row]
//        
//        let alert = UIAlertController(
//            title: "Item \(productListItem.index) selected!",
//            message: "🐶",
//            preferredStyle: .alert
//        )
//        
//        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil) )
//        
//        present(alert, animated: true, completion: nil)
    }
}

extension StandaloneListViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
//        guard
//            sections.indices.contains(section)
//        else {
//            return 0
//        }
        
//        return sections[section].items.count
        return viewModel?.numberOfProducts() ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let product = viewModel?.getProduct(at: indexPath.row),
//            sections.indices.contains(indexPath.section),
//            sections[indexPath.section].items.indices.contains(indexPath.row),
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductItemCVC.reuseIdentifier,
                for: indexPath
            ) as? ProductItemCVC
        else {
            return UICollectionViewCell()
        }
        
//        let listItem = sections[indexPath.section].items[indexPath.row]
        
//        cell.listItemView.configure(for: listItem)
        if let viewModel = viewModel, let product = viewModel.getProduct(at: indexPath.row) {
            cell.configureFor(product: product)
        }
        
        return cell
    }
}

private extension StandaloneListItemView {
    func configure(for listItem: ListItem) {
        titleLabel.text = listItem.title
        priceLabel.text = listItem.price
        productImage.image = listItem.image
    }
}
