//
//  HomeRouter.swift
//  getir-finalcase
//
//  Created by Mustafa Yücel on 12.04.2024.
//

import Foundation

enum HomeRoutes {
    case basketScreen
    case detailScreen
}

protocol HomeRouterProtocol: AnyObject {
    func navigate(to route: HomeRoutes, withArgs args: [String: Any])
}

final class HomeRouter {
    
    weak var vc: HomeViewController?
    
    static func createModule() -> HomeViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.output = presenter
        router.vc = view
        
        return view
    }
    
}


extension HomeRouter: HomeRouterProtocol {
    
    func navigate(to route: HomeRoutes, withArgs args: [String: Any]) {
        switch route {
        case .basketScreen:
            let newVc = BasketRouter.createModule()
            vc?.navigationController?.pushViewController(newVc, animated: true)
        case .detailScreen:
            guard let product = args["product"] as? Product else { return }
            
            let newVc = DetailRouter.createModule(product)
            vc?.navigationController?.pushViewController(newVc, animated: true)
        }
    }
    
}
