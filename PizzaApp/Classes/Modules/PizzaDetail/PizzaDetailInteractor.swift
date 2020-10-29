//
//  PizzaDetailInteractor.swift
//  PizzaApp
//
//  Created by CongTung on 1/2/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import Foundation

class PizzaDetailInteractor: PresenterToInteractorPizzaDetailProtocol {
  
  // MARK: Properties
  weak var presenter: InteractorToPresenterPizzaDetailProtocol?
  var pizza: Pizza?
  
  func getImageData() {
    guard let pizza = pizza else {
      return
    }
    print("Interactor receives the request from Presenter to get image data from the server.")
    guard let image = pizza.image else {
      self.presenter?.getImageFromURLFailure(pizza: pizza)
      return
    }
    self.presenter?.getImageFromURLSuccess(pizza: pizza, image: ImageDataService.shared.convertToUIImage(from: image))
  }
}
