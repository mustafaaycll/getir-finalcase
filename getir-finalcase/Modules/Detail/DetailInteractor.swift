//
//  DetailInteractor.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 13.04.2024.
//

import Foundation

protocol DetailInteractorProtocol: AnyObject {
    func basketIncludes(_ product: Product) -> Bool
    func countInBasket(of product: Product) -> Int
    func addToBasket(_ product: Product)
    func removeFromBasket(_ product: Product)
}

protocol DetailInteractorOutputProtocol: AnyObject {
    func basketChanged()
}

final class DetailInteractor {
    var output: DetailInteractorOutputProtocol?
}

extension DetailInteractor: DetailInteractorProtocol {
    func basketIncludes(_ product: Product) -> Bool {
        return User.shared.basketIncludes(product)
    }
    
    func countInBasket(of product: Product) -> Int {
        return User.shared.countInBasket(of: product)
    }
    
    func addToBasket(_ product: Product) {
        User.shared.addToBasket(product)
        self.output?.basketChanged()
    }
    
    func removeFromBasket(_ product: Product) {
        User.shared.removeFromBasket(product)
        self.output?.basketChanged()
    }
}
