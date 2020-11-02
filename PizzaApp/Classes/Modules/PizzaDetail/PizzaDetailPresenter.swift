//
//  PizzaDetailPresenter.swift
//  PizzaApp
//
//  Created by CongTung on 1/2/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import Foundation
import UIKit.UIImage
import RxSwift

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
    self.view?.onGetImageFromURLSuccess(pizza.desc ?? "", image: image)
  }
  
  func getImageFromURLFailure(errorMessage: String) {
    print("Presenter receives the result from Interactor after it's done its job.")
    view?.onGetImageFromURLFailure(errorMessage)
  }
  
}
