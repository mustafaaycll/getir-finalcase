//
//  BottomBarView.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 22.04.2024.
//

import UIKit

class BottomBarView: UIView {
    
    private let containerView = UIView()
    
    init() {
        super.init(frame: .zero)
        configureViewAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureViewAndConstraints() {
        self.backgroundColor = Config.Components.BottomBar.Visual.Colors.viewBackgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        containerView.backgroundColor = .clear
        containerView.layer.cornerRadius = Config.Components.BottomBar.Dimensions.containerCornerRadius
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = true
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Config.Components.BottomBar.Dimensions.containerViewLeadingPadding
            ),
            containerView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Config.Components.BottomBar.Dimensions.containerViewTopPadding
            ),
            containerView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: Config.Components.BottomBar.Dimensions.containerViewTrailingPadding
            ),
            containerView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: Config.Components.BottomBar.Dimensions.containerViewBottomPadding
            ),
        ])
    }
    
    private func clearContainer() {
        for subview in containerView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func display(_ subview: UIView, stretched: Bool, widthHeightRatio: Double? = nil) {
        clearContainer()
        containerView.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: containerView.topAnchor),
            subview.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            subview.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
        
        if stretched {
            NSLayoutConstraint.activate([
                subview.widthAnchor.constraint(
                    equalTo: containerView.widthAnchor,
                    multiplier: Config.Components.BottomBar.Dimensions.stretchedViewWidthToContainerWidthRatio
                )
            ])
        } else if let ratio = widthHeightRatio {
            NSLayoutConstraint.activate([
                subview.widthAnchor.constraint(
                    equalTo: containerView.heightAnchor,
                    multiplier: ratio
                )
            ])
        } else {
            NSLayoutConstraint.activate([
                subview.widthAnchor.constraint(
                    equalTo: containerView.widthAnchor,
                    multiplier: Config.Components.BottomBar.Dimensions.unstretchedViewWidthToContainerWidthRatio
                )
            ])
        }
    }
}
