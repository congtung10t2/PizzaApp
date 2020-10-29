//
//  PizzaDetailPresenter.swift
//  PizzaApp
//
//  Created by CongTung on 1/2/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import Foundation
import UIKit.UIImage

class PizzaDetailPresenter: ViewToPresenterPizzaDetailProtocol {
  
  // MARK: Properties
  weak var view: PresenterToViewPizzaDetailProtocol?
  var interactor: PresenterToInteractorPizzaDetailProtocol?
  var router: PresenterToRouterPizzaDetailProtocol?
  
  func viewDidLoad() {
    print("Presenter is being notified that the View was loaded.")
    interactor?.getImageData()
  }
  
}

extension PizzaDetailPresenter: InteractorToPresenterPizzaDetailProtocol {
  func getImageFromURLSuccess(pizza: Pizza, image: UIImage) {
    guard let desc = pizza.desc, let image = pizza.image else { return }
    view?.onGetImageFromURLSuccess(desc, image: ImageDataService.shared.convertToUIImage(from: image))
  }
  
  func getImageFromURLFailure(pizza: Pizza) {
    print("Presenter receives the result from Interactor after it's done its job.")
    view?.onGetImageFromURLFailure(pizza.desc ?? "Failed")
  }
  
}
