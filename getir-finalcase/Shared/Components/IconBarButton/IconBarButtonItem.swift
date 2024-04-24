//
//  IconBarButtonItem.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 22.04.2024.
//

import UIKit

class IconBarButtonItem: UIBarButtonItem {
    private var containerView = UIView()
    private var imageView = UIImageView()
    
    init(displaying image: UIImage, targeting target: AnyObject, withAction action: Selector) {
        super.init()
        configureContainerView(with: action, targeting: target)
        configureContainerViewConstraints()
        configureImageView(with: image)
        configureImageViewConstraints()
        
        self.customView = containerView
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureContainerView(with action: Selector, targeting target: AnyObject) {
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
        containerView.backgroundColor = Config.Components.IconBarButton.Visual.Colors.viewBackgroundColor
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = Config.Components.IconBarButton.Dimensions.cornerRadius
        containerView.addSubview(imageView)
    }
    
    private func configureContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(
                equalToConstant: Config.Components.IconBarButton.Dimensions.width
            ),
            containerView.heightAnchor.constraint(
                equalToConstant: Config.Components.IconBarButton.Dimensions.height
            )
        ])
    }
    
    private func configureImageView(with image: UIImage) {
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
    }
    
    private func configureImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: Config.Components.IconBarButton.Dimensions.imageViewLeadingPadding
            ),
            imageView.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: Config.Components.IconBarButton.Dimensions.imageViewTopPadding
            ),
            imageView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: Config.Components.IconBarButton.Dimensions.imageViewTrailingPadding
            ),
            imageView.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: Config.Components.IconBarButton.Dimensions.imageViewBottomPadding
            )
        ])
    }
}
