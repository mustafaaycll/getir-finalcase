//
//  ProductTileCollectionViewCell.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 14.04.2024.
//

import UIKit

class ProductTileCollectionViewCell: UICollectionViewCell {
    
    private var verticalStepperView: VerticalStepperView?
    
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
        backgroundColor = Config.Components.ProductTile.Visual.Colors.viewBackgroundColor
        
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
        containerView.backgroundColor = Config.Components.ProductTile.Visual.Colors.containerBackgroundColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Config.Components.ProductTile.Dimensions.containerViewTopPadding
            ),
            containerView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Config.Components.ProductTile.Dimensions.containerViewLeadingPadding
            ),
            containerView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: Config.Components.ProductTile.Dimensions.containerViewTrailingPadding
            ),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureImageView() {
        imageView.contentMode = Config.Components.ProductTile.Visual.ContentModes.productImageContentMode
        imageView.layer.cornerRadius = Config.Components.ProductTile.Dimensions.imageCornerRadius
        imageView.clipsToBounds = true
        imageView.layer.borderColor = Config.Components.ProductTile.Visual.Colors.defaultImageBorderColor?.cgColor
        imageView.layer.borderWidth = Config.Components.ProductTile.Dimensions.imageBorderWidth
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
    
    private func configureLabels() {
        priceLabel.textAlignment = Config.Components.ProductTile.Text.Alignments.priceLabelAlignment
        priceLabel.font = Config.Components.ProductTile.Text.Fonts.priceLabelFont
        priceLabel.textColor = Config.Components.ProductTile.Visual.Colors.priceTextColor
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textAlignment = Config.Components.ProductTile.Text.Alignments.titleLabelAlignment
        titleLabel.font = Config.Components.ProductTile.Text.Fonts.titleLabelFont
        titleLabel.textColor = Config.Components.ProductTile.Visual.Colors.titleTextColor
        titleLabel.numberOfLines = Config.Components.ProductTile.Text.Properties.titleLabelNumberOfLines
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        attrLabel.textAlignment = Config.Components.ProductTile.Text.Alignments.attrLabelAlignment
        attrLabel.font = Config.Components.ProductTile.Text.Fonts.attrLabelFont
        attrLabel.textColor = Config.Components.ProductTile.Visual.Colors.attrTextColor
        attrLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func configureLabelConstraints() {
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: Config.Components.ProductTile.Dimensions.priceLabelTopPadding
            ),
            priceLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(
                equalTo: priceLabel.bottomAnchor,
                constant: Config.Components.ProductTile.Dimensions.titleLabelTopPadding
            ),
            titleLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            
            attrLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Config.Components.ProductTile.Dimensions.attrLabelTopPadding
            ),
            attrLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
    
    private func identifyVerticalStepperState(by count: Int) -> StepperStates {
        if count == 0 {
            return .collapsedState
        } else if count == 1 {
            return .expandedButReadyToBeCollapsedState
        } else {
            return .expandedState
        }
    }
    
    private func configureVerticalStepperViewConstraintsAccording(to state: StepperStates) {
        verticalStepperView!.translatesAutoresizingMaskIntoConstraints = false
        switch state {
        case .collapsedState:
            NSLayoutConstraint.activate([
                verticalStepperView!.topAnchor.constraint(
                    equalTo: self.topAnchor,
                    constant: Config.Components.ProductTile.Dimensions.verticalStepperTopPadding
                ),
                verticalStepperView!.trailingAnchor.constraint(
                    equalTo: self.trailingAnchor,
                    constant: Config.Components.ProductTile.Dimensions.verticalStepperTrailingPadding
                ),
                verticalStepperView!.widthAnchor.constraint(
                    equalTo: self.widthAnchor,
                    multiplier: Config.Components.ProductTile.Dimensions.stepperWidthToViewWidthRatio
                ),
                verticalStepperView!.heightAnchor.constraint(
                    equalTo: verticalStepperView!.widthAnchor,
                    multiplier: Config.Components.Stepper.Dimensions.widthHeightRationWhenCollapsed
                )
            ])
        case .expandedButReadyToBeCollapsedState, .expandedState:
            NSLayoutConstraint.activate([
                verticalStepperView!.topAnchor.constraint(
                    equalTo: self.topAnchor,
                    constant: Config.Components.ProductTile.Dimensions.verticalStepperTopPadding
                ),
                verticalStepperView!.trailingAnchor.constraint(
                    equalTo: self.trailingAnchor,
                    constant: Config.Components.ProductTile.Dimensions.verticalStepperTrailingPadding
                ),
                verticalStepperView!.widthAnchor.constraint(
                    equalTo: self.widthAnchor,
                    multiplier: Config.Components.ProductTile.Dimensions.stepperWidthToViewWidthRatio
                ),
                verticalStepperView!.heightAnchor.constraint(
                    equalTo: verticalStepperView!.widthAnchor,
                    multiplier: Config.Components.Stepper.Dimensions.heightWidthRatioWhenExpandedVerticallly
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
    
    func setHighlighted(_ highlighted: Bool) {
        if highlighted {
            imageView.layer.borderColor = Config.Components.ProductTile.Visual.Colors.highlightedImageBorderColor?.cgColor
        } else {
            imageView.layer.borderColor = Config.Components.ProductTile.Visual.Colors.defaultImageBorderColor?.cgColor
        }
    }
    
    func attachStepper(withCount count: Int, targeting target: AnyObject, withPlusAction plusAction: Selector, withMinusAction minusAction: Selector, withTrashAction trashAction: Selector) {
        if let product = assignedProduct {
            verticalStepperView?.removeFromSuperview()
            let state = identifyVerticalStepperState(by: count)
            verticalStepperView = VerticalStepperView(
                in: state,
                with: count,
                targeting: target,
                withPlusAction: plusAction,
                withMinusAction: minusAction,
                withTrashAction: trashAction,
                referencing: product
            )
            self.addSubview(verticalStepperView!)
            configureVerticalStepperViewConstraintsAccording(to: state)
        }
    }
}
