//
//  BasketTileCollectionViewCell.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 22.04.2024.
//

import UIKit

class BasketTileCollectionViewCell: UICollectionViewCell {
    private var horizontalStepperView: HorizontalStepperView?
    
    var assignedProduct: Product?
    
    let containerView = UIView()
    let imageView = UIImageView()
    let priceLabel = UILabel()
    let titleLabel = UILabel()
    let attrLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func assign(_ productToBeAssigned: Product) {
        assignedProduct = productToBeAssigned
        display()
    }
    
    private func configureView() {
        backgroundColor = Config.Components.BasketTile.Visual.Colors.viewBackgroundColor
        
        configureContainerView()
        addSubview(containerView)
        configureContainerViewConstraints()
        
        configureImageView()
        containerView.addSubview(imageView)
        configureImageViewConstraints()
        
        configureLabels()
        containerView.addSubview(priceLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(attrLabel)
        configureLabelConstraints()
        
    }
    
    private func configureContainerView() {
        containerView.backgroundColor = Config.Components.BasketTile.Visual.Colors.containerBackgroundColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Config.Components.BasketTile.Dimensions.containerViewTopPadding
            ),
            containerView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Config.Components.BasketTile.Dimensions.containerViewLeadingPadding
            ),
            containerView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: Config.Components.BasketTile.Dimensions.containerViewTrailingPadding
            ),
            containerView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: Config.Components.BasketTile.Dimensions.containerViewBottomPadding
            )
        ])
    }
    
    private func configureImageView() {
        imageView.contentMode = Config.Components.BasketTile.Visual.ContentModes.productImageContentMode
        imageView.layer.cornerRadius = Config.Components.BasketTile.Dimensions.imageCornerRadius
        imageView.clipsToBounds = true
        imageView.layer.borderColor = Config.Components.BasketTile.Visual.Colors    .imageBorderColor?.cgColor
        imageView.layer.borderWidth = Config.Components.BasketTile.Dimensions.imageBorderWidth
    }
    
    private func configureImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
    
    private func configureLabels() {
        priceLabel.textAlignment = Config.Components.BasketTile.Text.Alignments.priceLabelAlignment
        priceLabel.font = Config.Components.BasketTile.Text.Fonts.priceLabelFont
        priceLabel.textColor = Config.Components.BasketTile.Visual.Colors.priceTextColor
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textAlignment = Config.Components.BasketTile.Text.Alignments.titleLabelAlignment
        titleLabel.font = Config.Components.BasketTile.Text.Fonts.titleLabelFont
        titleLabel.textColor = Config.Components.BasketTile.Visual.Colors.titleTextColor
        titleLabel.numberOfLines = Config.Components.BasketTile.Text.Properties.titleLabelNumberOfLines
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        attrLabel.textAlignment = Config.Components.BasketTile.Text.Alignments.attrLabelAlignment
        attrLabel.font = Config.Components.BasketTile.Text.Fonts.attrLabelFont
        attrLabel.textColor = Config.Components.BasketTile.Visual.Colors.attrTextColor
        attrLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func configureLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: Config.Components.BasketTile.Dimensions.titleLabelTopPadding
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: imageView.trailingAnchor,
                constant: Config.Components.BasketTile.Dimensions.titleLabelLeadingPadding
            ),
            titleLabel.widthAnchor.constraint(
                equalTo: containerView.widthAnchor,
                multiplier: Config.Components.BasketTile.Dimensions.labelWidthToContainerWidthRatio
            ),
            
            attrLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Config.Components.BasketTile.Dimensions.attrLabelTopPadding
            ),
            attrLabel.leadingAnchor.constraint(
                equalTo: imageView.trailingAnchor,
                constant: Config.Components.BasketTile.Dimensions.attrLabelLeadingPadding
            ),
            attrLabel.widthAnchor.constraint(
                equalTo: titleLabel.widthAnchor
            ),
            
            priceLabel.topAnchor.constraint(
                equalTo: attrLabel.bottomAnchor,
                constant: Config.Components.BasketTile.Dimensions.priceLabelTopPadding
            ),
            priceLabel.leadingAnchor.constraint(
                equalTo: imageView.trailingAnchor,
                constant: Config.Components.BasketTile.Dimensions.priceLabelLeadingPadding
            ),
            priceLabel.widthAnchor.constraint(
                equalTo: titleLabel.widthAnchor
            ),
        ])
    }
    
    private func identifyHorizontalStepperState(by count: Int) -> StepperStates {
        if count == 0 {
            return .collapsedState
        } else if count == 1 {
            return .expandedButReadyToBeCollapsedState
        } else {
            return .expandedState
        }
    }
    
    private func configureHorizontalStepperViewConstraintsAccording(to state: StepperStates) {
        horizontalStepperView!.translatesAutoresizingMaskIntoConstraints = false
        switch state {
        case .collapsedState:
            NSLayoutConstraint.activate([
                horizontalStepperView!.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                horizontalStepperView!.widthAnchor.constraint(equalToConstant: 0),
                horizontalStepperView!.heightAnchor.constraint(equalToConstant: 0)
            ])
        case .expandedButReadyToBeCollapsedState, .expandedState:
            NSLayoutConstraint.activate([
                horizontalStepperView!.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
                horizontalStepperView!.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                horizontalStepperView!.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                horizontalStepperView!.heightAnchor.constraint(
                    equalTo: self.heightAnchor,
                    multiplier: Config.Components.BasketTile.Dimensions.horizontalStepperHeigthToViewHeigthRatio
                )
            ])
        }
    }
    
    private func display() {
        if let product = assignedProduct {
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
            
            priceLabel.text = product.priceText
            titleLabel.text = product.name
            attrLabel.text = product.attribute
        }
    }
    
    func attachStepper(withCount count: Int, targeting target: AnyObject, withPlusAction plusAction: Selector, withMinusAction minusAction: Selector, withTrashAction trashAction: Selector) {
        if let product = assignedProduct {
            horizontalStepperView?.removeFromSuperview()
            let state = identifyHorizontalStepperState(by: count)
            horizontalStepperView = HorizontalStepperView(
                in: state,
                with: count,
                targeting: target,
                withPlusAction: plusAction,
                withMinusAction: minusAction,
                withTrashAction: trashAction,
                referencing: product
            )
            self.addSubview(horizontalStepperView!)
            configureHorizontalStepperViewConstraintsAccording(to: state)
        }
    }
}
