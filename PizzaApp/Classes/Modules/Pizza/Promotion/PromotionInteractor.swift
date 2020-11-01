//
//  PromotionInteractor.swift
//  PizzaApp
//
//  Created by TungImac on 10/31/20.
//  Copyright © 2020 TungImac. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class PromotionInteractor {
  public var promotionRelay = BehaviorRelay<[Promotion]>(value: [])
  let disposeBag = DisposeBag()
  func loadPromotion() {
    PizzaService.shared.getPromotion().bind(to: promotionRelay).disposed(by: disposeBag)
  }
}
