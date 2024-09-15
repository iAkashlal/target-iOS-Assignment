//
//  ProductItemCVC.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 15/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import SDWebImage
import UIKit

class ProductItemCVC: UICollectionViewCell {
    
    static let reuseIdentifier = "ProductItemCVC"

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var strikeoffPriceLabel: UILabel!
    @IBOutlet weak var fulfillmentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var stockIndicatorLabel: UILabel!
    @IBOutlet weak var aisleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDesign()
    }
    
    func setupDesign() {
        // Setup Image
        productImage.layer.cornerRadius = 8.0
        productImage.clipsToBounds = true
        
        
        // Setup Item Price Label
        itemPriceLabel.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        itemPriceLabel.textAlignment = .left
        let text = "$34.99"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 25 - itemPriceLabel.font.lineHeight
        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .font: itemPriceLabel.font!,
                .paragraphStyle: paragraphStyle
            ]
        )
        itemPriceLabel.attributedText = attributedString
        itemPriceLabel.textColor = UIColor.targetRed

        
        // strikeoffPriceLabel
        let strikeoffPriceLabel = UILabel()
        strikeoffPriceLabel.font = UIFont.systemFont(ofSize: 33, weight: .regular)
        strikeoffPriceLabel.textAlignment = .left

//        let strikeoffParagraphStyle = NSMutableParagraphStyle()
//        strikeoffParagraphStyle.lineSpacing = 20.5 - strikeoffPriceLabel.font.lineHeight
//        let strikeoffAttributedString = NSAttributedString(
//            string: "Strikeoff Price",
//            attributes: [
//                .font: strikeoffPriceLabel.font!,
//                .paragraphStyle: strikeoffParagraphStyle
//            ]
//        )
//        strikeoffPriceLabel.attributedText = strikeoffAttributedString
        strikeoffPriceLabel.textColor = UIColor.grayDarkest

        // fulfillmentLabel
        let fulfillmentLabel = UILabel()
        fulfillmentLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        fulfillmentLabel.textAlignment = .left

        let fulfillmentParagraphStyle = NSMutableParagraphStyle()
        fulfillmentParagraphStyle.lineSpacing = 16 - fulfillmentLabel.font.lineHeight
        let fulfillmentAttributedString = NSAttributedString(
            string: "Fulfillment",
            attributes: [
                .font: fulfillmentLabel.font!,
                .paragraphStyle: fulfillmentParagraphStyle
            ]
        )
        fulfillmentLabel.attributedText = fulfillmentAttributedString
        fulfillmentLabel.textColor = UIColor.textLightGray

        // titleLabel
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.textAlignment = .left

        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.lineSpacing = 19 - titleLabel.font.lineHeight
        let titleAttributedString = NSAttributedString(
            string: "Title",
            attributes: [
                .font: titleLabel.font!,
                .paragraphStyle: titleParagraphStyle
            ]
        )
        titleLabel.attributedText = titleAttributedString
        titleLabel.numberOfLines = 3
        titleLabel.textColor = UIColor.black

        // stockIndicatorLabel
        let stockIndicatorLabel = UILabel()
        stockIndicatorLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        stockIndicatorLabel.textAlignment = .center

        let stockIndicatorParagraphStyle = NSMutableParagraphStyle()
        stockIndicatorParagraphStyle.lineSpacing = 16 - stockIndicatorLabel.font.lineHeight
        let stockIndicatorAttributedString = NSAttributedString(
            string: "In Stock",
            attributes: [
                .font: stockIndicatorLabel.font!,
                .paragraphStyle: stockIndicatorParagraphStyle
            ]
        )
        stockIndicatorLabel.attributedText = stockIndicatorAttributedString
        stockIndicatorLabel.textColor = UIColor.targetTextGreen

        // aisleLabel
        let aisleLabel = UILabel()
        aisleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        aisleLabel.textAlignment = .center

        let aisleParagraphStyle = NSMutableParagraphStyle()
        aisleParagraphStyle.lineSpacing = 16 - aisleLabel.font.lineHeight
        let aisleAttributedString = NSAttributedString(
            string: "Aisle",
            attributes: [
                .font: aisleLabel.font!,
                .paragraphStyle: aisleParagraphStyle
            ]
        )
        aisleLabel.attributedText = aisleAttributedString
        aisleLabel.textColor = UIColor.textLightGray
        
    }
    
    func configureFor(product: Product) {
        productImage.sd_setImage(with: product.imageUrl?.asURL())
        
        if product.isDiscounted {
            itemPriceLabel.text = product.salePrice?.displayString ?? "$NaN"
            strikeoffPriceLabel.text = product.regularPrice?.displayString ?? "$NaN"
        } else {
            itemPriceLabel.text = product.regularPrice?.displayString ?? "$NaN"
            strikeoffPriceLabel.isHidden = true
        }
        fulfillmentLabel.text = product.fulfillment
        titleLabel.text = product.title
        
        switch product.stockInfo {
        case .inStock:
            stockIndicatorLabel.text = product.availability
            aisleLabel.text = "in aisle " + product.aisle.uppercased()
        case .soldOut:
            stockIndicatorLabel.text = product.availability
            stockIndicatorLabel.textColor = UIColor.targetRed
            aisleLabel.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        productImage.image = nil
        itemPriceLabel.text = ""
        strikeoffPriceLabel.text = ""
        fulfillmentLabel.text = ""
        titleLabel.text = ""
        stockIndicatorLabel.text = ""
        stockIndicatorLabel.textColor = UIColor.targetTextGreen
        aisleLabel.text = ""
    }

}
