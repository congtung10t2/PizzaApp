//
//  PizzaRouter.swift
//  PizzaApp
//
//  Created by CongTung on 1/2/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import UIKit

class PizzaRouter: PresenterToRouterPizzaProtocol {
    
    
    // MARK: Static methods
    static func createModule() -> UINavigationController {
        
        print("PizzaRouter creates the Pizza module.")
        let viewController = PizzaViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: ViewToPresenterPizzaProtocol & InteractorToPresenterPizzaProtocol = PizzaPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = PizzaRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = PizzaInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigationController
    }
    
    // MARK: - Navigation
    func pushToPizzaDetail(on view: PresenterToViewPizzaProtocol, with pizza: Pizza) {
        print("PizzaRouter is instructed to push PizzaDetailViewController onto the navigation stack.")
        let pizzaDetailViewController = PizzaDetailRouter.createModule(with: pizza)
            
        let viewController = view as! PizzaViewController
        viewController.navigationController?
            .pushViewController(pizzaDetailViewController, animated: true)
        
    }
    
}
