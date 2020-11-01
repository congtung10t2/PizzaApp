//
//  PizzaPresenter.swift
//  PizzaApp
//
//  Created by CongTung on 1/2/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import Foundation

class PizzaPresenter: ViewToPresenterPizzaProtocol {
  
  // MARK: Properties
  weak var view: PresenterToViewPizzaProtocol?
  var interactor: PresenterToInteractorPizzaProtocol?
  var router: PresenterToRouterPizzaProtocol?
  
  var pizzaTitles: [Pizza]?
  
  // MARK: Inputs from view
  func viewDidLoad() {
    print("Presenter is being notified that the View was loaded.")
    view?.showHUD()
    interactor?.loadPizza()
  }
  
  func refresh() {
    print("Presenter is being notified that the View was refreshed.")
    interactor?.loadPizza()
  }
  
  func numberOfRowsInSection() -> Int {
    pizzaTitles?.count ?? 0
  }
  
  func textLabelText(indexPath: IndexPath) -> String? {
    guard let pizzaTitles = self.pizzaTitles else {
      return nil
    }
    
    return pizzaTitles[indexPath.row].title
  }
  
  
  func didSelectRowAt(index: Int) {
    interactor?.retrievePizza(at: index)
  }
  
  func deselectRowAt(index: Int) {
    view?.deselectRowAt(row: index)
  }
  
}

// MARK: - Outputs to view
extension PizzaPresenter: InteractorToPresenterPizzaProtocol {
  func checkOut(pizza: [Pizza: Int]) {
    router?.pushToPizzaCheckout(on: view!, pizza: pizza)
  }
  
  
  func fetchPizzaSuccess(pizza: [Pizza]) {
    print("Presenter receives the result from Interactor after it's done its job.")
    self.pizzaTitles = pizza
    view?.hideHUD()
    view?.onFetchPizzaSuccess()
  }
  
  func fetchPizzaFailure(errorCode: Int) {
    print("Presenter receives the result from Interactor after it's done its job.")
    view?.hideHUD()
    view?.onFetchPizzaFailure(error: "Couldn't fetch Pizza: \(errorCode)")
  }
  
  func getPizzaSuccess(_ pizza: Pizza) {
    router?.pushToPizzaDetail(on: view!, with: pizza)
  }
  
  func getPizzaFailure() {
    view?.hideHUD()
    print("Couldn't retrieve Pizza by index")
  }
  
  
}
