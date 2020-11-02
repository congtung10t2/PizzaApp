//
//  PizzaDetailInteractor.swift
//  PizzaApp
//
//  Created by CongTung on 1/2/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import Foundation
import RxSwift

class PizzaDetailInteractor: PresenterToInteractorPizzaDetailProtocol {
  let disposeBag = DisposeBag()
  // MARK: Properties
  weak var presenter: InteractorToPresenterPizzaDetailProtocol?
  var pizza: Pizza?
  
  func getImageData() {
    guard let pizza = pizza else {
      return
    }
    print("Interactor receives the request from Presenter to get image data from the server.")
    guard let image = pizza.image else { return }
    ImageDataService.shared.convertToUIImage(from: image).subscribe(onNext: { [weak self] image in
      guard let self = self else { return }
      self.presenter?.getImageFromURLSuccess(pizza: pizza, image: image)
      
    }, onError: { error in
      self.presenter?.getImageFromURLFailure(errorMessage: error.localizedDescription)
    }).disposed(by: disposeBag)
  }
}
