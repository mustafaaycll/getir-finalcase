//
//  ProductDetailPresenter.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 13.04.2024.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func getProduct() -> Product
    func basketIncludes(_ product: Product) -> Bool
    func getCountInBasket(of product: Product) -> Int
    func didSelectPlusButton(for product: Product)
    func didSelectMinusButton(for product: Product)
    func didSelectTrashButton(for product: Product)
}

final class DetailPresenter {
    unowned var view: DetailViewControllerProtocol!
    let interactor: DetailInteractorProtocol!
    let router: DetailRouterProtocol!
    var product: Product!
    
    init(view: DetailViewControllerProtocol, interactor: DetailInteractorProtocol, router: DetailRouterProtocol, product: Product) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.product = product
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func viewDidLoad() {
        
    }
    
    func getProduct() -> Product {
        return product
    }
    
    func basketIncludes(_ product: Product) -> Bool {
        return interactor.basketIncludes(product)
    }
    
    func getCountInBasket(of product: Product) -> Int {
        return interactor.countInBasket(of: product)
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

extension DetailPresenter: DetailInteractorOutputProtocol {
    func basketChanged() {
        view.reload()
    }
}
