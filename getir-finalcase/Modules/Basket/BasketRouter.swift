//
//  BasketRouter.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 13.04.2024.
//

import Foundation

enum BasketRoutes {
    case detailScreen
}

protocol BasketRouterProtocol: AnyObject {
    func navigate(to route: BasketRoutes, withArgs args: [String: Any])
}

final class BasketRouter {
    
    weak var vc: BasketViewController?
    
    static func createModule() -> BasketViewController {
        let view = BasketViewController()
        let interactor = BasketInteractor()
        let router = BasketRouter()
        
        let presenter = BasketPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.output = presenter
        router.vc = view
        
        return view
    }
}

extension BasketRouter: BasketRouterProtocol {
    func navigate(to route: BasketRoutes, withArgs args: [String: Any]) {
        switch route {
        case .detailScreen:
            guard let product = args["product"] as? Product else { return }
            let newVc = DetailRouter.createModule(product)
            vc?.navigationController?.pushViewController(newVc, animated: true)
        }
    }
}
