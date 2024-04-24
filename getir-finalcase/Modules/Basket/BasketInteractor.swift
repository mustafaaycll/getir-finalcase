//
//  BasketInteractor.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 13.04.2024.
//

import Foundation
import RxSwift
import RxMoya

protocol BasketInteractorProtocol: AnyObject {
    func fetchData()
    func addToBasket(_ product: Product)
    func removeFromBasket(_ product: Product)
    func purchaseBasket()
    func emptyBasket()
    func isBasketEmpty() -> Bool
    func getCostOfBasket() -> Double
    func basketIncludes(_ product: Product) -> Bool
    func countInBasket(of product: Product) -> Int
}

protocol BasketInteractorOutputProtocol: AnyObject {
    func dataFetched(output: [String: [Product]])
    func basketChanged(output: [String: [Product]])
    func shoppingCompleted(output: [String: [Product]])
}

final class BasketInteractor {
    var data: [String: [Product]] = [
        "basket": [],
        "suggestedProducts": [],
    ]
    var disposeBag = DisposeBag()
    var output: BasketInteractorOutputProtocol?
}

extension BasketInteractor: BasketInteractorProtocol {
    func fetchData() {
        NetworkManager.shared.getSuggestedProducts().subscribe { categories in
            var products: [Product] = []
            for category in categories {
                products += category.products
            }
            self.data["basket"] = User.shared.getProductsInBasket()
            self.data["suggestedProducts"] = products
            self.output?.dataFetched(output: self.data)
            
        } onFailure: { error in
            print(error)
        }
        .disposed(by: disposeBag)
    }
    
    func addToBasket(_ product: Product) {
        User.shared.addToBasket(product)
        self.data["basket"] = User.shared.getProductsInBasket()
        self.output?.basketChanged(output: self.data)
    }
    
    func removeFromBasket(_ product: Product) {
        User.shared.removeFromBasket(product)
        self.data["basket"] = User.shared.getProductsInBasket()
        self.output?.basketChanged(output: self.data)
    }
    
    func purchaseBasket() {
        User.shared.emptyBasket()
        self.data["basket"] = User.shared.getProductsInBasket()
        self.output?.shoppingCompleted(output: self.data)
    }
    
    func emptyBasket() {
        User.shared.emptyBasket()
        self.data["basket"] = User.shared.getProductsInBasket()
        self.output?.basketChanged(output: self.data)
    }
    
    func isBasketEmpty() -> Bool {
        return User.shared.isBasketEmpty()
    }
    
    func getCostOfBasket() -> Double {
        return User.shared.getCostOfBasket()
    }
    
    func basketIncludes(_ product: Product) -> Bool {
        return User.shared.basketIncludes(product)
    }
    
    func countInBasket(of product: Product) -> Int {
        return User.shared.countInBasket(of: product)
    }
}
