//
//  HomeInteractor.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 12.04.2024.
//

import Foundation
import RxSwift
import RxMoya

protocol HomeInteractorProtocol: AnyObject {
    func fetchData()
    func addToBasket(_ product: Product)
    func removeFromBasket(_ product: Product)
    func isBasketEmpty() -> Bool
    func getCostOfBasket() -> Double
    func basketIncludes(_ product: Product) -> Bool
    func countInBasket(of product: Product) -> Int
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func dataFetched(output: [String: [Product]])
    func basketChanged()
}

final class HomeInteractor {
    var data: [String: [Product]] = [
        "allProducts": [],
        "suggestedProducts": [],
    ]
    var disposeBag = DisposeBag()
    var output: HomeInteractorOutputProtocol?
}

extension HomeInteractor: HomeInteractorProtocol {
    func fetchData() {
        NetworkManager.shared.getProducts().subscribe { categories in
            var products: [Product] = []
            for category in categories {
                products += category.products
            }
            self.data["allProducts"] = products
            
            NetworkManager.shared.getSuggestedProducts().subscribe { categories in
                var products: [Product] = []
                for category in categories {
                    products += category.products
                }
                self.data["suggestedProducts"] = products
                self.output?.dataFetched(output: self.data)
            } onFailure: { error in
                print(error)
            }
            .disposed(by: self.disposeBag)
            
        } onFailure: { error in
            print(error)
        }
        .disposed(by: disposeBag)
    }
    
    func addToBasket(_ product: Product) {
        User.shared.addToBasket(product)
        self.output?.basketChanged()
    }
    
    func removeFromBasket(_ product: Product) {
        User.shared.removeFromBasket(product)
        self.output?.basketChanged()
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
