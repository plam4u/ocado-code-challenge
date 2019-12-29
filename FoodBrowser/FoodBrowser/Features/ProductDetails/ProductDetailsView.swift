//
//  ProductDetailsView.swift
//  FoodBrowser
//
//  Created by Plamen on 12/28/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import UIKit

class ProductDetailsView: UIView {
    private var stackView: UIStackView = {
        let spacing: CGFloat = 16
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // add padding around the stack view content
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: spacing,
                                                                     leading: spacing,
                                                                     bottom: spacing,
                                                                     trailing: spacing)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = spacing
        return stackView
    }()

    private let product: ProductDetails

    init(product: ProductDetails) {
        self.product = product

        super.init(frame: .zero)

        addStackView()
        addImage()
        addDescription()
        addAllergyInformation()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProductDetailsView {
    func addStackView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
            // the bottom is left opened on purpose which means the content could grow out-of-screen.
            // we do not handle scrolling for this demo
        ])
    }

    func addImage() {
        let imageView = UIImageView(image: UIImage(named: "placeholder"))
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        stackView.addArrangedSubview(imageView)
        imageView.loadImage(urlString: product.imageUrl)
    }

    func addDescription() {
        let label = makeLabel()
        label.text = "\nDescription:\n\n\(product.description)"
        stackView.addArrangedSubview(label)
    }

    func addAllergyInformation() {
        let label = makeLabel()
        label.text = "\nAllergy Information:\n\n\(product.allergyInformation)"
        stackView.addArrangedSubview(label)
    }

    func makeLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }
}
