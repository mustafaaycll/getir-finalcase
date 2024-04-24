//
//  HomeViewController.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 12.04.2024.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func reload()
    func alert(title: String, message: String)
}

class HomeViewController: BaseViewController {
    
    var presenter: HomePresenterProtocol!
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    private var basketIndicator: BasketIndicatorBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    private func configureView() {
        title = Config.Modules.Home.Text.Texts.moduleTitleText
        view.backgroundColor = Config.Modules.Home.Visual.Colors.viewBackgroundColor
        basketIndicator = BasketIndicatorBarButtonItem(
            indicating: presenter.getBasketPriceText(),
            withAction: #selector(didSelectBasketIndicator),
            targeting: self
        )
        navigationItem.rightBarButtonItem = basketIndicator
        view.addSubview(collectionView)
        configureCollectionView()
        configureCollectionViewConstraints()
    }
    
    private func configureCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureCollectionView() {
        collectionView.register(
            ProductTileCollectionViewCell.self,
            forCellWithReuseIdentifier: Config.Modules.Home.Text.Texts.suggestionSectionCellReuseIdentifierText
        )
        collectionView.register(
            ProductTileCollectionViewCell.self,
            forCellWithReuseIdentifier: Config.Modules.Home.Text.Texts.productSectionCellReuseIdentifierText
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = Config.Modules.Home.Visual.Colors.collectionBackgroundColor
        collectionView.contentInset = Config.Modules.Home.Dimensions.collectionContentInset
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = Config.Modules.Home.Dimensions.collectionInterSectionSpacing
        
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
    
    private func getCustomSection(by sectionType: HomeSectionTypes) -> NSCollectionLayoutSection {
        switch sectionType {
        case .suggestionSection:
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: Config.Modules.Home.Dimensions.suggestionSectionItemWidth,
                    heightDimension: Config.Modules.Home.Dimensions.suggestionSectionItemHeight
                )
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: Config.Modules.Home.Dimensions.suggestionSectionGroupWidth,
                    heightDimension: Config.Modules.Home.Dimensions.suggestionSectionGroupHeight
                ),
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.decorationItems = Config.Modules.Home.Visual.Decorations.suggestionSectionDecorationItems
            
            return section
            
        case .productsSection:
            var subitems: [NSCollectionLayoutItem] = []
            
            for _ in 0..<Config.Modules.Home.Dimensions.productsSectionItemCountPerRow {
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: Config.Modules.Home.Dimensions.productSectionItemWidth,
                        heightDimension: Config.Modules.Home.Dimensions.productSectionItemHeight
                    )
                )
                subitems.append(item)
            }
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: Config.Modules.Home.Dimensions.productSectionGroupWidth,
                    heightDimension: Config.Modules.Home.Dimensions.productSectionGroupHeight
                ),
                subitems: subitems
            )
            
            let section = NSCollectionLayoutSection(group: group)
            section.decorationItems = Config.Modules.Home.Visual.Decorations.productSectionDecorationItems
            
            return section
        }
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    func reload() {
        collectionView.reloadData()
        basketIndicator.updatePrice(with: presenter.getBasketPriceText())
    }
    
    func alert(title: String, message: String) {
        showAlert(title: title, message: message)
    }
}

extension HomeViewController {
    @objc private func didSelectBasketIndicator() {
        presenter.didSelectBasketIndicator()
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        case .suggestionSection:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Config.Modules.Home.Text.Texts.suggestionSectionCellReuseIdentifierText,
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
            
        case .productsSection:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Config.Modules.Home.Text.Texts.productSectionCellReuseIdentifierText,
                for: indexPath
            ) as! ProductTileCollectionViewCell
            
            cell.assign(product)
            cell.setHighlighted(ifInBasket)
            cell.attachStepper(
                withCount: countInBasket,
                targeting: self,
                withPlusAction: #selector(didSelectPlusButton),
                withMinusAction: #selector(didSelectMinusButton),
                withTrashAction: #selector(didSelectTrashButton))
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
}
