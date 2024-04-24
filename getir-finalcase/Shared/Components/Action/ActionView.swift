//
//  ActionView.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 22.04.2024.
//

import UIKit

class ActionView: UIView {

    private let actionButton = ActionButton()
    private let actionLabel = ActionLabel()
    
    private var includesInfo: Bool!
    
    init(
        withActionText actionText: String,
        targeting target: Any,
        withAction action: Selector,
        withInformationText infoText: String? = nil
    ) {
        super.init(frame: .zero)
        includesInfo = (infoText != nil) ? true : false
        configureView()
        configureActionButton(
            withActionText: actionText,
            targeting: target,
            withAction: action
        )
        if includesInfo {
            configureActionInfo(withInformationText: infoText)
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureView() {
        backgroundColor = Config.Components.Action.Visual.Colors.viewBackgroundColor
        addSubview(actionButton)
        addSubview(actionLabel)
    }
    
    private func configureActionButton(
        withActionText actionText: String,
        targeting target: Any,
        withAction action: Selector
    ) {
        actionButton.setTitle(actionText, for: .normal)
        actionButton.addTarget(target, action: action, for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        configureActionButtonConstraints()
    }
    
    private func configureActionButtonConstraints() {
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            actionButton.topAnchor.constraint(equalTo: topAnchor),
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            actionButton.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: getActionButtonWidthMultiplier()
            ),
        ])
    }
    
    private func configureActionInfo(withInformationText infoText: String?) {
        actionLabel.text = infoText
        actionLabel.translatesAutoresizingMaskIntoConstraints = false
        configureActionInfoConstraints()
    }
    
    private func configureActionInfoConstraints() {
        NSLayoutConstraint.activate([
            actionLabel.leadingAnchor.constraint(equalTo: actionButton.trailingAnchor),
            actionLabel.topAnchor.constraint(equalTo: topAnchor),
            actionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            actionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func getActionButtonWidthMultiplier() -> CGFloat {
        if includesInfo {
            return Config.Components.Action.Dimensions.actionButtonWidthMultiplierWhenWithInfo
        } else {
            return Config.Components.Action.Dimensions.actionButtonWidthMultiplierWhenNoInfo
        }
    }
    
    func updateInfo(_ text: String) {
        guard includesInfo else { return }
        actionLabel.text = text
    }
}
