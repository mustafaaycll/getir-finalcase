//
//  ProductDetailView.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 23.04.2024.
//

import UIKit

class ProductDetailView: UIView {
    
    private var product: Product!
    private let imageView = UIImageView()
    private let priceLabel = UILabel()
    private let titleLabel = UILabel()
    private let attrLabel = UILabel()
    
    init(displaying productToBeDisplayed: Product) {
        super.init(frame: .zero)
        product = productToBeDisplayed
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureView() {
        self.backgroundColor = Config.Components.ProductDetail.Visual.Colors.viewBackgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        
        configureImageView()
        self.addSubview(imageView)
        configureImageViewConstraints()
        
        configureLabels()
        self.addSubview(priceLabel)
        self.addSubview(titleLabel)
        self.addSubview(attrLabel)
        configureLabelConstraints()
    }
    
    private func configureImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let cacheKey = NSString(string: product.availableImageURL)
        
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            self.imageView.image = cachedImage
        } else if let url = URL(string: product.availableImageURL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                let image = UIImage(data: data)
                ImageCacheManager.shared.setObject(image!, forKey: cacheKey)
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = image
                }
            }.resume()
        }
    }
    
    private func configureImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(
                equalTo: heightAnchor,
                multiplier: Config.Components.ProductDetail.Dimensions.imageHeightToViewHeightRatio
            ),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
    
    private func configureLabels() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textAlignment = Config.Components.ProductDetail.Text.Alignments.priceLabelAlignment
        priceLabel.font = Config.Components.ProductDetail.Text.Fonts.priceLabelFont
        priceLabel.textColor = Config.Components.ProductDetail.Visual.Colors.priceTextColor
        priceLabel.text = product.priceText
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = Config.Components.ProductDetail.Text.Alignments.titleLabelAlignment
        titleLabel.font = Config.Components.ProductDetail.Text.Fonts.titleLabelFont
        titleLabel.textColor = Config.Components.ProductDetail.Visual.Colors.titleTextColor
        titleLabel.numberOfLines = Config.Components.ProductDetail.Text.Properties.titleLabelNumberOfLines
        titleLabel.text = product.name
        
        attrLabel.translatesAutoresizingMaskIntoConstraints = false
        attrLabel.textAlignment = Config.Components.ProductDetail.Text.Alignments.attrLabelAlignment
        attrLabel.font = Config.Components.ProductDetail.Text.Fonts.attrLabelFont
        attrLabel.textColor = Config.Components.ProductDetail.Visual.Colors.attrTextColor
        attrLabel.text = product.attribute
    }
    
    private func configureLabelConstraints() {
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: Config.Components.ProductDetail.Dimensions.priceLabelTopPadding
            ),
            priceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            priceLabel.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: Config.Components.ProductDetail.Dimensions.priceLabelWidthtoViewWidthRatio
            ),
            
            titleLabel.topAnchor.constraint(
                equalTo: priceLabel.bottomAnchor,
                constant: Config.Components.ProductDetail.Dimensions.titleLabelTopPadding
            ),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: Config.Components.ProductDetail.Dimensions.titleLabelWidthtoViewWidthRatio
            ),
            
            attrLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Config.Components.ProductDetail.Dimensions.attrLabelTopPadding
            ),
            attrLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            attrLabel.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: Config.Components.ProductDetail.Dimensions.attrLabelWidthtoViewWidthRatio
            )
        ])
    }

}
