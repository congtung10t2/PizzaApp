//
//  PizzaCheckoutRouter.swift
//  PizzaApp
//
//  Created TungImac on 11/1/20.
//  Copyright © 2020 TungImac. All rights reserved.
//

import UIKit

class PizzaCheckoutRouter: PizzaCheckoutWireframeProtocol {
  
  weak var viewController: UIViewController?
  
  static func createModule(pizza: [Pizza: Int]) -> UIViewController {
    // Change to get view from storyboard if not using progammatic UI
    let view = PizzaCheckoutViewController(nibName: nil, bundle: nil)
    view.items.accept(pizza)
    let interactor = PizzaCheckoutInteractor()
    let router = PizzaCheckoutRouter()
    let presenter = PizzaCheckoutPresenter(interface: view, interactor: interactor, router: router)
    
    view.presenter = presenter
    interactor.presenter = presenter
    router.viewController = view
    
    return view
  }
}
