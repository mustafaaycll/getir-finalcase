//
//  BasketIndicatorBarButtonItem.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 14.04.2024.
//

import UIKit

class BasketIndicatorBarButtonItem: UIBarButtonItem {
    private var containerView = UIView()
    private var imageContainerView = UIView()
    private var imageView = UIImageView()
    private var priceContainerView = UIView()
    private var priceLabel = UILabel()
    
    init(
        indicating priceText: String,
        withAction action: Selector,
        targeting target: AnyObject
    ) {
        super.init()
        
        configureContainerView(with: action, targeting: target)
        configureContainerViewConstraints()
        
        configureImageContainerView()
        containerView.addSubview(imageContainerView)
        configureImageContainerViewConstraints()
        
        configureImageView()
        containerView.addSubview(imageView)
        configureImageViewConstraints()
        
        configurePriceView()
        containerView.addSubview(priceContainerView)
        configurePriceViewConstraints()
        
        configurePriceLabel(with: priceText)
        containerView.addSubview(priceLabel)
        configurePriceLabelConstraints()
        
        self.customView = containerView
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updatePrice(with text: String) {
        priceLabel.text = text
    }
    
    private func configureContainerView(with action: Selector, targeting target: AnyObject) {
        containerView.addGestureRecognizer(
            UITapGestureRecognizer(target: target, action: action)
        )
        containerView.backgroundColor = Config.Components.BasketIndicator.Visual.Colors.viewBackgroundColor
        containerView.clipsToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = Config.Components.BasketIndicator.Dimensions.cornerRadius
    }
    
    private func configureContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(
                equalToConstant: Config.Components.BasketIndicator.Dimensions.width
            ),
            containerView.heightAnchor.constraint(
                equalToConstant: Config.Components.BasketIndicator.Dimensions.height
            )
        ])
    }
    
    private func configureImageContainerView() {
        imageContainerView.backgroundColor = Config.Components.BasketIndicator.Visual.Colors.imageBackgroundColor
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureImageContainerViewConstraints() {
        NSLayoutConstraint.activate([
            imageContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageContainerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            imageContainerView.widthAnchor.constraint(equalTo: imageContainerView.heightAnchor)
        ])
    }
    
    private func configureImageView() {
        imageView.contentMode = Config.Components.BasketIndicator.Visual.ContentModes.imageContentMode
        imageView.image = Config.Components.BasketIndicator.Visual.Images.bagImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(
                equalTo: imageContainerView.leadingAnchor,
                constant: Config.Components.BasketIndicator.Dimensions.imageViewLeadingPadding
            ),
            imageView.topAnchor.constraint(
                equalTo: imageContainerView.topAnchor,
                constant: Config.Components.BasketIndicator.Dimensions.imageViewTopPadding
            ),
            imageView.trailingAnchor.constraint(
                equalTo: imageContainerView.trailingAnchor,
                constant: Config.Components.BasketIndicator.Dimensions.imageViewTrailingPadding
            ),
            imageView.bottomAnchor.constraint(
                equalTo: imageContainerView.bottomAnchor,
                constant: Config.Components.BasketIndicator.Dimensions.imageViewBottomPadding
            )
        ])
    }
    
    private func configurePriceView() {
        priceContainerView.backgroundColor = Config.Components.BasketIndicator.Visual.Colors.priceContainerBackgroundColor
        priceContainerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configurePriceViewConstraints() {
        NSLayoutConstraint.activate([
            priceContainerView.leadingAnchor.constraint(equalTo: imageContainerView.trailingAnchor),
            priceContainerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            priceContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            priceContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    private func configurePriceLabel(with text: String) {
        priceLabel.text = text
        priceLabel.textAlignment = Config.Components.BasketIndicator.Text.Alignments.priceLabelAlignment
        priceLabel.font = Config.Components.BasketIndicator.Text.Fonts.priceLabelFont
        priceLabel.textColor = Config.Components.BasketIndicator.Visual.Colors.priceTextColor
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configurePriceLabelConstraints() {
        NSLayoutConstraint.activate([
            priceLabel.centerXAnchor.constraint(equalTo: priceContainerView.centerXAnchor),
            priceLabel.centerYAnchor.constraint(equalTo: priceContainerView.centerYAnchor)
        ])
    }
}
