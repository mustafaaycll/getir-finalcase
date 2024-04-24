//
//  BasketPresenter.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 13.04.2024.
//

import Foundation

protocol BasketPresenterProtocol: AnyObject {
    func viewDidLoad()
    func getNumberOfSections() -> Int
    func identifySection(by sectionIndex: Int) -> BasketSectionTypes
    func getNumberOfItems(in sectionIndex: Int) -> Int
    func getItem(at indexPath: IndexPath) -> Product
    func getBasketPriceText() -> String
    func basketIncludes(_ product: Product) -> Bool
    func getCountInBasket(of product: Product) -> Int
    func didSelectItem(at indexPath: IndexPath)
    func didSelectActionButton()
    func didSelectClearButton()
    func didSelectPlusButton(for product: Product)
    func didSelectMinusButton(for product: Product)
    func didSelectTrashButton(for product: Product)
}

final class BasketPresenter {
    unowned var view: BasketViewControllerProtocol!
    let interactor: BasketInteractorProtocol!
    let router: BasketRouterProtocol!
    
    init(view: BasketViewControllerProtocol, interactor: BasketInteractorProtocol, router: BasketRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    var basket: [Product] = []
    var suggestedProducts: [Product] = []
}

extension BasketPresenter: BasketPresenterProtocol {
    func viewDidLoad() {
        interactor.fetchData()
    }
    
    func getNumberOfSections() -> Int {
        return BasketSectionTypes.allCases.count
    }
    
    func identifySection(by sectionIndex: Int) -> BasketSectionTypes {
        if sectionIndex == 0 {
            return .basketSection
        } else {
            return .suggestionSection
        }
    }
    
    func getNumberOfItems(in sectionIndex: Int) -> Int {
        let sectionType = identifySection(by: sectionIndex)
        switch sectionType {
        case .basketSection:
            return basket.count
        case .suggestionSection:
            return suggestedProducts.count
        }
    }
    
    func getItem(at indexPath: IndexPath) -> Product {
        let sectionType = identifySection(by: indexPath.section)
        switch sectionType {
        case .basketSection:
            return basket[indexPath.item]
        case .suggestionSection:
            return suggestedProducts[indexPath.item]
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
        case .basketSection:
            router.navigate(to: .detailScreen, withArgs: ["product": basket[indexPath.item]])
        case .suggestionSection:
            router.navigate(to: .detailScreen, withArgs: ["product": suggestedProducts[indexPath.item]])
        }
    }
    
    func didSelectActionButton() {
        interactor.purchaseBasket()
    }
    
    func didSelectClearButton() {
        interactor.emptyBasket()
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

extension BasketPresenter: BasketInteractorOutputProtocol {
    func dataFetched(output: [String : [Product]]) {
        self.basket = output["basket"]!
        self.suggestedProducts = output["suggestedProducts"]!
        view.reload()
    }
    
    func basketChanged(output: [String: [Product]]) {
        self.basket = output["basket"]!
        self.suggestedProducts = output["suggestedProducts"]!
        if interactor.isBasketEmpty() {
            view.alert(title: "Sepet Temizlendi", message: "Sepetiniz isteğiniz üzerine temizlendi")
            view.pop()
        } else {
            view.reload()
        }
        
    }
    
    func shoppingCompleted(output: [String : [Product]]) {
        self.basket = output["basket"]!
        self.suggestedProducts = output["suggestedProducts"]!
        view.alert(title: "Alışveriş Tamamlandı", message: "Kuryelerimiz en kısa sürede siparişinizi size ulaştıracak, teşekkürler!")
        view.pop()
    }
}
