//
//  PizzaInteractor.swift
//  PizzaApp
//
//  Created by CongTung on 1/2/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import Foundation
import RxSwift
class PizzaInteractor: PresenterToInteractorPizzaProtocol {
  
  // MARK: Properties
  weak var presenter: InteractorToPresenterPizzaProtocol?
  var pizza: [Pizza]?
  let disposeBag = DisposeBag()
  
  func loadPizza() {
    PizzaService.shared.getPizza().subscribe(onNext: { value in
      self.pizza = value
      self.presenter?.fetchPizzaSuccess(pizza: value)
    }, onError: { error in
      self.presenter?.fetchPizzaFailure(error: error)
    }).disposed(by: disposeBag)
 
    
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
