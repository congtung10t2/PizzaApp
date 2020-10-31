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
  func loadPromotion() {
    PizzaService.shared.getPromotion(success: { (code, promotion) in
      self.promotionRelay.accept(promotion)
    }, failure: { code in
      print(code)
    })
  }
}
