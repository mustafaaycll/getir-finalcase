//
//  DetailRouter.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 13.04.2024.
//

import Foundation

enum DetailRoutes {
    
}

protocol DetailRouterProtocol: AnyObject {
    
}

final class DetailRouter {
    
    weak var vc: DetailViewController?
    
    static func createModule(_ product: Product) -> DetailViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        
        let presenter = DetailPresenter(view: view, interactor: interactor, router: router, product: product)
        
        view.presenter = presenter
        interactor.output = presenter
        router.vc = view
        
        return view
    }
}

extension DetailRouter: DetailRouterProtocol {
    
}
