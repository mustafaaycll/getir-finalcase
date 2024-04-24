//
//  BasketViewController.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 13.04.2024.
//

import UIKit

protocol BasketViewControllerProtocol: AnyObject {
    func reload()
    func pop()
    func alert(title: String, message: String)
}

class BasketViewController: BaseViewController {
    
    var presenter: BasketPresenterProtocol!
    
    private var actionView: ActionView!
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    private let bottomBarView = BottomBarView()
    
    private var clearBarButtonItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidLoad()
    }
    
    private func configureView() {
        title = Config.Modules.Basket.Text.Texts.moduleTitleText
        
        view.backgroundColor = Config.Modules.Basket.Visual.Colors.viewBackgroundColor
        
        clearBarButtonItem = IconBarButtonItem(
            displaying: Config.Modules.Basket.Visual.Images.trashImage,
            targeting: self,
            withAction: #selector(didSelectClearButton)
        )
        navigationItem.rightBarButtonItem = clearBarButtonItem
        
        view.addSubview(bottomBarView)
        configureBottomBarView()
        configureBottomBarViewConstraints()
        
        view.addSubview(collectionView)
        configureCollectionView()
        configureCollectionViewConstraints()
    }
    
    private func configureBottomBarView() {
        bottomBarView.translatesAutoresizingMaskIntoConstraints = false
        actionView = ActionView(
            withActionText: Config.Modules.Basket.Text.Texts.moduleActionText,
            targeting: self,
            withAction: #selector(didSelectActionButton),
            withInformationText: presenter.getBasketPriceText()
        )
        bottomBarView.display(actionView, stretched: true)
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
    
    private func configureCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomBarView.topAnchor)
        ])
    }
    
    private func configureCollectionView() {
        collectionView.register(
            BasketTileCollectionViewCell.self,
            forCellWithReuseIdentifier: Config.Modules.Basket.Text.Texts.basketSectionCellReuseIdentifierText
        )
        collectionView.register(
            ProductTileCollectionViewCell.self,
            forCellWithReuseIdentifier: Config.Modules.Basket.Text.Texts.suggestionSectionCellReuseIdentifierText
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = Config.Modules.Basket.Visual.Colors.collectionBackgroundColor
        collectionView.contentInset = Config.Modules.Basket.Dimensions.collectionContentInset
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = Config.Modules.Basket.Dimensions.collectionInterSectionSpacing
        
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: { [weak self] sectionIndex, layoutEnvironment in
                let sectionType = self?.presenter.identifySection(by: sectionIndex)
                return self?.getCustomSection(by: sectionType!)
            },
            configuration: config
        )
        
        layout.register(
            SectionCollectionReusableView.self,
            forDecorationViewOfKind: SectionCollectionReusableView.elementKind
        )
        
        return layout
    }
    
    private func getCustomSection(by sectionType: BasketSectionTypes) -> NSCollectionLayoutSection {
        switch sectionType {
        case .basketSection:
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension:  Config.Modules.Basket.Dimensions.basketSectionItemWidth,
                    heightDimension:  Config.Modules.Basket.Dimensions.basketSectionItemHeight
                )
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: .init(
                    widthDimension:  Config.Modules.Basket.Dimensions.basketSectionGroupWidth,
                    heightDimension: Config.Modules.Basket.Dimensions.basketSectionGroupHeight
                ),
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            section.decorationItems = Config.Modules.Basket.Visual.Decorations.basketSectionDecorationItems
            
            return section
            
        case .suggestionSection:
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: Config.Modules.Basket.Dimensions.suggestionSectionItemWidth,
                    heightDimension: Config.Modules.Basket.Dimensions.suggestionSectionItemHeight
                )
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: Config.Modules.Basket.Dimensions.suggestionSectionGroupWidth,
                    heightDimension: Config.Modules.Basket.Dimensions.suggestionSectionGroupHeight
                ),
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.decorationItems = Config.Modules.Basket.Visual.Decorations.suggestionSectionDecorationItems
            
            return section
        }
    }
}

extension BasketViewController: BasketViewControllerProtocol {
    func reload() {
        collectionView.reloadData()
        actionView.updateInfo(presenter.getBasketPriceText())
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func alert(title: String, message: String) {
        showAlert(title: title, message: message)
    }
}

extension BasketViewController {
    @objc func didSelectActionButton() {
        presenter.didSelectActionButton()
    }
    
    @objc func didSelectClearButton() {
        presenter.didSelectClearButton()
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

extension BasketViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.getNumberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getNumberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product: Product = presenter.getItem(at: indexPath)
        let ifInBasket = presenter.basketIncludes(product)
        let countInBasket: Int = presenter.getCountInBasket(of: product)
        let sectionType = presenter.identifySection(by: indexPath.section)
        
        switch sectionType {
        case .basketSection:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Config.Modules.Basket.Text.Texts.basketSectionCellReuseIdentifierText,
                for: indexPath
            ) as! BasketTileCollectionViewCell
            cell.assign(product)
            cell.attachStepper(
                withCount: countInBasket,
                targeting: self,
                withPlusAction: #selector(didSelectPlusButton),
                withMinusAction: #selector(didSelectMinusButton),
                withTrashAction: #selector(didSelectTrashButton)
            )
            
            return cell
            
        case .suggestionSection:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Config.Modules.Basket.Text.Texts.suggestionSectionCellReuseIdentifierText,
                for: indexPath
            ) as! ProductTileCollectionViewCell
            cell.assign(product)
            cell.setHighlighted(ifInBasket)
            cell.attachStepper(
                withCount: countInBasket,
                targeting: self,
                withPlusAction: #selector(didSelectPlusButton),
                withMinusAction: #selector(didSelectMinusButton),
                withTrashAction: #selector(didSelectTrashButton)
            )
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
}
