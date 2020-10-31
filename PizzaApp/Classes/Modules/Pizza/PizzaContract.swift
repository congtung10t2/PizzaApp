//
//  PizzaContract.swift
//  PizzaApp
//
//  Created by CongTung on 1/2/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewPizzaProtocol: class {
  func onFetchPizzaSuccess()
  func onFetchPizzaFailure(error: String)
  func showHUD()
  func hideHUD()
  
  func deselectRowAt(row: Int)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterPizzaProtocol: class {
  
  var view: PresenterToViewPizzaProtocol? { get set }
  var interactor: PresenterToInteractorPizzaProtocol? { get set }
  var router: PresenterToRouterPizzaProtocol? { get set }
  
  var pizzaTitles: [Pizza]? { get set }
  
  
  func viewDidLoad()
  
  func refresh()
  
  func numberOfRowsInSection() -> Int
  func textLabelText(indexPath: IndexPath) -> String?
  
  func didSelectRowAt(index: Int)
  func deselectRowAt(index: Int)
  
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorPizzaProtocol: class {
  
  var presenter: InteractorToPresenterPizzaProtocol? { get set }
  
  func loadPizza()
  func retrievePizza(at index: Int)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterPizzaProtocol: class {
  
  func fetchPizzaSuccess(pizza: [Pizza])
  func fetchPizzaFailure(errorCode: Int)
  
  func getPizzaSuccess(_ pizza: Pizza)
  func getPizzaFailure()
  
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterPizzaProtocol: class {
  
  static func createModule() -> UINavigationController
  
  func pushToPizzaDetail(on view: PresenterToViewPizzaProtocol, with Pizza: Pizza)
}
