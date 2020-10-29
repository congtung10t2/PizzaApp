//
//  PizzaDetailRouter.swift
//  PizzaApp
//
//  Created by CongTung on 1/2/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import Foundation
import UIKit

class PizzaDetailRouter: PresenterToRouterPizzaDetailProtocol {
    
    // MARK: Static methods
    static func createModule(with pizza: Pizza) -> UIViewController {
        print("PizzaDetailRouter creates the PizzaDetail module.")
        let viewController = PizzaDetailViewController()
        
        let presenter: ViewToPresenterPizzaDetailProtocol & InteractorToPresenterPizzaDetailProtocol = PizzaDetailPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = PizzaDetailRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = PizzaDetailInteractor()
        viewController.presenter?.interactor?.pizza = pizza
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
