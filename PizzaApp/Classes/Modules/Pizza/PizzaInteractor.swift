//
//  PizzaInteractor.swift
//  PizzaApp
//
//  Created by CongTung on 1/2/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import Foundation

class PizzaInteractor: PresenterToInteractorPizzaProtocol {
  
  // MARK: Properties
  weak var presenter: InteractorToPresenterPizzaProtocol?
  var pizza: [Pizza]?
  
  func loadPizza() {
    print("Interactor receives the request from Presenter to load Pizza from the server.")
    PizzaService.shared.getPizza( success: { (code, pizza) in
      self.pizza = pizza
      self.presenter?.fetchPizzaSuccess(pizza: pizza)
    }) { (code) in
      self.presenter?.fetchPizzaFailure(errorCode: code)
    }
    
  }
  
  func retrievePizza(at index: Int) {
    guard let pizza = self.pizza, pizza.indices.contains(index) else {
      self.presenter?.getPizzaFailure()
      return
    }
    self.presenter?.getPizzaSuccess(self.pizza![index])
  }
  
  func checkOut(pizza: [Pizza: Int]) {
    self.presenter?.checkOut(pizza: pizza)
  }
}
