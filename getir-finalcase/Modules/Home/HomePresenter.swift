//
//  HomePresenter.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 12.04.2024.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func getNumberOfSections() -> Int
    func identifySection(by sectionIndex: Int) -> HomeSectionTypes
    func getNumberOfItems(in sectionIndex: Int) -> Int
    func getItem(at indexPath: IndexPath) -> Product
    func getBasketPriceText() -> String
    func basketIncludes(_ product: Product) -> Bool
    func getCountInBasket(of product: Product) -> Int
    func didSelectItem(at indexPath: IndexPath)
    func didSelectBasketIndicator()
    func didSelectPlusButton(for product: Product)
    func didSelectMinusButton(for product: Product)
    func didSelectTrashButton(for product: Product)
}

final class HomePresenter {
    unowned var view: HomeViewControllerProtocol!
    let interactor: HomeInteractorProtocol!
    let router: HomeRouterProtocol!
    
    init(view: HomeViewControllerProtocol, interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    var products: [Product] = []
    var suggestedProducts: [Product] = []
}

extension HomePresenter: HomePresenterProtocol {
    func viewDidLoad() {
        interactor.fetchData()
    }
    
    func getNumberOfSections() -> Int {
        return HomeSectionTypes.allCases.count
    }
    
    func identifySection(by sectionIndex: Int) -> HomeSectionTypes {
        if sectionIndex == 0 {
            return .suggestionSection
        } else {
            return .productsSection
        }
    }
    
    func getNumberOfItems(in sectionIndex: Int) -> Int {
        let sectionType = identifySection(by: sectionIndex)
        switch sectionType {
        case .suggestionSection:
            return suggestedProducts.count
        case .productsSection:
            return products.count
        }
    }
    
    func getItem(at indexPath: IndexPath) -> Product {
        let sectionType = identifySection(by: indexPath.section)
        switch sectionType {
        case .suggestionSection:
            return suggestedProducts[indexPath.item]
        case .productsSection:
            return products[indexPath.item]
        }
    }
    
    func getBasketPriceText() -> String {
        return "₺" + String(format: "%.2f" , interactor.getCostOfBasket())
    }
    
    func basketIncludes(_ product: Product) -> Bool {
        return interactor.basketIncludes(product)
    }
    
    func getCountInBasket(of product: Product) -> Int {
        return interactor.countInBasket(of: product)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let sectionType = identifySection(by: indexPath.section)
        switch sectionType {
        case .suggestionSection:
            router.navigate(to: .detailScreen, withArgs: ["product": suggestedProducts[indexPath.item]])
        case .productsSection:
            router.navigate(to: .detailScreen, withArgs: ["product": products[indexPath.item]])
        }
    }
    
    func didSelectBasketIndicator() {
        if interactor.isBasketEmpty() {
            self.view.alert(title: "Sepet Boş", message: "Sepetinizde görüntülenecek bir şey yok.")
        } else {
            router.navigate(to: .basketScreen, withArgs: [:])
        }
    }
    
    func didSelectPlusButton(for product: Product) {
        interactor.addToBasket(product)
    }
    
    func didSelectMinusButton(for product: Product) {
        interactor.removeFromBasket(product)
    }
    
    func didSelectTrashButton(for product: Product) {
        interactor.removeFromBasket(product)
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func dataFetched(output: [String : [Product]]) {
        self.products = output["allProducts"]!
        self.suggestedProducts = output["suggestedProducts"]!
        view.reload()
    }
    
    func basketChanged() {
        view.reload()
    }
}
