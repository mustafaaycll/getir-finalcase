//
//  HorizontalStepperView.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 22.04.2024.
//

import UIKit

class HorizontalStepperView: UIView {

    private let plusButton = StepperButton(
        withImage: Config.Components.Stepper.Visual.Images.plusImage
    )
    private let minusButton = StepperButton(
        withImage: Config.Components.Stepper.Visual.Images.minusImage
    )
    private let trashButton = StepperButton(
        withImage: Config.Components.Stepper.Visual.Images.trashImage
    )
    
    private let stepCountView = UIView()
    private let stepCountLabel = UILabel()
    
    init(
        in state: StepperStates,
        with count: Int,
        targeting target: AnyObject,
        withPlusAction plusAction: Selector,
        withMinusAction minusAction: Selector,
        withTrashAction trashAction: Selector,
        referencing reference: Product
    ) {
        super.init(frame: .zero)
        
        configureButtons(
            withTarget: target,
            withPlusAction: plusAction,
            withMinusAction: minusAction,
            withTrashAction: trashAction,
            withReference: reference
        )
        configureStepCountView(with: count)
        
        configureViewAndConstraints(of: state)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureViewAndConstraints(of state: StepperStates) {
        self.backgroundColor = Config.Components.Stepper.Visual.Colors.viewBackgroundColor
        self.layer.cornerRadius = Config.Components.Stepper.Dimensions.cornerRadius
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.borderWidth = Config.Components.Stepper.Dimensions.borderWidth
        self.layer.borderColor = Config.Components.Stepper.Visual.Colors.viewBorderColor?.cgColor
        
        switch state {
        case .collapsedState:
            self.addSubview(plusButton)
            NSLayoutConstraint.activate([
                plusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                plusButton.topAnchor.constraint(equalTo: self.topAnchor),
                plusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                plusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
        case .expandedButReadyToBeCollapsedState:
            self.addSubview(plusButton)
            NSLayoutConstraint.activate([
                plusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                plusButton.topAnchor.constraint(equalTo: self.topAnchor),
                plusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                plusButton.widthAnchor.constraint(
                    equalTo: self.widthAnchor,
                    multiplier: Config.Components.Stepper.Dimensions.buttonViewProportion
                )
            ])
            self.addSubview(stepCountView)
            NSLayoutConstraint.activate([
                stepCountView.topAnchor.constraint(equalTo: self.topAnchor),
                stepCountView.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor),
                stepCountView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                stepCountView.widthAnchor.constraint(
                    equalTo: self.widthAnchor,
                    multiplier: Config.Components.Stepper.Dimensions.buttonViewProportion
                )
            ])
            self.addSubview(trashButton)
            NSLayoutConstraint.activate([
                trashButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                trashButton.topAnchor.constraint(equalTo: self.topAnchor),
                trashButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                trashButton.widthAnchor.constraint(
                    equalTo: self.widthAnchor,
                    multiplier: Config.Components.Stepper.Dimensions.buttonViewProportion
                )
            ])
        case .expandedState:
            self.addSubview(plusButton)
            NSLayoutConstraint.activate([
                plusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                plusButton.topAnchor.constraint(equalTo: self.topAnchor),
                plusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                plusButton.widthAnchor.constraint(
                    equalTo: self.widthAnchor,
                    multiplier: Config.Components.Stepper.Dimensions.buttonViewProportion
                )
            ])
            self.addSubview(stepCountView)
            NSLayoutConstraint.activate([
                stepCountView.topAnchor.constraint(equalTo: self.topAnchor),
                stepCountView.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor),
                stepCountView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                stepCountView.widthAnchor.constraint(
                    equalTo: self.widthAnchor,
                    multiplier: Config.Components.Stepper.Dimensions.buttonViewProportion
                )
            ])
            self.addSubview(minusButton)
            NSLayoutConstraint.activate([
                minusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                minusButton.topAnchor.constraint(equalTo: self.topAnchor),
                minusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                minusButton.widthAnchor.constraint(
                    equalTo: self.widthAnchor,
                    multiplier: Config.Components.Stepper.Dimensions.buttonViewProportion
                )
            ])
        }
    }
    
    private func configureButtons(withTarget target: AnyObject, withPlusAction plusAction: Selector, withMinusAction minusAction: Selector, withTrashAction trashAction: Selector, withReference reference: Product) {
        
        plusButton.referenceProduct = reference
        minusButton.referenceProduct = reference
        trashButton.referenceProduct = reference
        
        plusButton.addTarget(target, action: plusAction, for: .touchUpInside)
        minusButton.addTarget(target, action: minusAction, for: .touchUpInside)
        trashButton.addTarget(target, action: trashAction, for: .touchUpInside)
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        trashButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureStepCountView(with count: Int) {
        stepCountView.backgroundColor = Config.Components.Stepper.Visual.Colors.stepCountBackgroundColor
        stepCountView.addSubview(stepCountLabel)
        stepCountView.translatesAutoresizingMaskIntoConstraints = false
        configureStepCountLabel(with: count)
        configureStepCountLabelConstraints()
    }
    
    private func configureStepCountLabel(with count: Int) {
        stepCountLabel.textColor = Config.Components.Stepper.Visual.Colors.stepCountTextColor
        stepCountLabel.text = String(count)
        stepCountLabel.font = Config.Components.Stepper.Text.Fonts.stepCountLabelFont
        stepCountLabel.textAlignment = Config.Components.Stepper.Text.Alignments.stepCountLabelAlignment
        stepCountLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureStepCountLabelConstraints() {
        NSLayoutConstraint.activate([
            stepCountLabel.leadingAnchor.constraint(equalTo: stepCountView.leadingAnchor),
            stepCountLabel.topAnchor.constraint(equalTo: stepCountView.topAnchor),
            stepCountLabel.trailingAnchor.constraint(equalTo: stepCountView.trailingAnchor),
            stepCountLabel.bottomAnchor.constraint(equalTo: stepCountView.bottomAnchor)
        ])
    }
}
