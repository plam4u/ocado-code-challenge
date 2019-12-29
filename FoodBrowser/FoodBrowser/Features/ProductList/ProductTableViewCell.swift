//
//  ProductTableViewCell.swift
//  FoodBrowser
//
//  Created by Plamen on 12/29/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with product: ProductPreview) {
        textLabel?.text = product.title
        detailTextLabel?.text = product.price
        imageView?.image = UIImage(named: "placeholder")
        imageView?.loadImage(urlString: product.imageUrl)
    }
}
