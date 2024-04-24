//
//  DetailViewController.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 13.04.2024.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func reload()
    func alert(title: String, message: String)
}

class DetailViewController: BaseViewController {
    
    var presenter: DetailPresenterProtocol!
    
    private var productDetailView: ProductDetailView!
    private let bottomBarView = BottomBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        title = Config.Modules.Detail.Text.Texts.moduleTitleText
        view.backgroundColor = Config.Modules.Detail.Visual.Colors.viewBackgroundColor
        
        productDetailView = ProductDetailView(displaying: presenter.getProduct())
        view.addSubview(productDetailView)
        configureProductDetailViewConstraints()
        
        configureBottomBarView()
        view.addSubview(bottomBarView)
        configureBottomBarViewConstraints()
        
    }
    
    private func configureProductDetailViewConstraints() {
        NSLayoutConstraint.activate([
            productDetailView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Config.Modules.Detail.Dimensions.productDetailTopPadding
            ),
            productDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productDetailView.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func configureBottomBarView() {
        bottomBarView.translatesAutoresizingMaskIntoConstraints = false
        
        let product = presenter.getProduct()
        
        if presenter.basketIncludes(product) {
            let count = presenter.getCountInBasket(of: product)
            let stepperState = identifyHorizontalStepperState(by: count)
            let actionView = HorizontalStepperView(
                in: stepperState,
                with: count,
                targeting: self,
                withPlusAction: #selector(didSelectPlusButton),
                withMinusAction: #selector(didSelectMinusButton),
                withTrashAction: #selector(didSelectTrashButton),
                referencing: product
            )
            bottomBarView.display(
                actionView,
                stretched: false,
                widthHeightRatio: Config.Components.Stepper.Dimensions.widthHeightRatioWhenExpandedHorizontally
            )
        } else {
            let actionView = ActionView(
                withActionText: Config.Modules.Detail.Text.Texts.moduleActionText,
                targeting: self,
                withAction: #selector(didSelectAddToBasket)
            )
            bottomBarView.display(actionView, stretched: true)
        }
    }
    
    private func configureBottomBarViewConstraints() {
        NSLayoutConstraint.activate([
            bottomBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomBarView.heightAnchor.constraint(
                equalTo: view.heightAnchor,
                multiplier: Config.Components.BottomBar.Dimensions.widthToScreenHeightRatio
            )
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
}

extension DetailViewController: DetailViewControllerProtocol {
    func reload() {
        configureBottomBarView()
    }
    
    func alert(title: String, message: String) {
        showAlert(title: title, message: message)
    }
}

extension DetailViewController {
    @objc func didSelectAddToBasket() {
        presenter.didSelectPlusButton(for: presenter.getProduct())
    }
    
    @objc private func didSelectPlusButton(_ sender: StepperButton) {
        presenter.didSelectPlusButton(for: sender.referenceProduct!)
    }
    
    @objc private func didSelectMinusButton(_ sender: StepperButton) {
        presenter.didSelectMinusButton(for: sender.referenceProduct!)
    }
    
    @objc private func didSelectTrashButton(_ sender: StepperButton) {
        presenter.didSelectTrashButton(for: sender.referenceProduct!)
    }
}
