//
//  User.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 13.04.2024.
//

import Foundation

class User {
    static let shared = User() // Singleton instance
    private init() {}

    var basket: [Product: Int] = [:]
    
    func addToBasket(_ product: Product) {
        basket[product, default: 0] += 1
    }
    
    func removeFromBasket(_ product: Product) {
        if let count = basket[product], count > 1 {
            basket[product] = count - 1
        } else {
            basket.removeValue(forKey: product)
        }
    }
    
    func basketIncludes(_ product: Product) -> Bool {
        return countInBasket(of: product) > 0
    }
    
    func countInBasket(of product: Product) -> Int {
        return basket[product] ?? 0
    }
    
    func emptyBasket() {
        basket = [:]
    }
    
    func getCostOfBasket() -> Double {
        return basket.reduce(0) { sum, pair in
            let (product, quantity) = pair
            return sum + (product.price * Double(quantity))
        }
    }
    
    func isBasketEmpty() -> Bool {
        return basket.count == 0
    }
    
    func getProductsInBasket() -> [Product] {
        return basket.keys.sorted { $0.name < $1.name }
    }
}
