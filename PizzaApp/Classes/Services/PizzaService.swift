//
//  PizzaService.swift
//  PizzaApp
//
//  Created by CongTung on 1/2/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import ObjectMapper
import Moya
import RxSwift

class PizzaService {
  static let shared = PizzaService()
  let provider = MoyaProvider<MoyaService>(stubClosure: MoyaProvider.immediatelyStub)
  
  func getPizza() -> Observable<[Pizza]> {
    return Observable.create { observe in
      return self.provider.rx.request(.pizza).subscribe { event in
        switch event {
          case let .success(response):
            do {
              let str = String(decoding: response.data, as: UTF8.self)
              if let pizza = Mapper<Pizza>().mapArray(JSONString: str) {
                observe.onNext(pizza)
              } else {
                let error = NSError(domain: "com.congtung.pizza", code: 1, userInfo: ["message": "Can't decode pizza"])
                observe.onError(error)
              }
            }
          case let .error(error):
            observe.onError(error)
        }
      }
    }
  }
  
  func getPromotion() -> Observable<[Promotion]> {
    return Observable.create { observe in
      return self.provider.rx.request(.promotion).subscribe { event in
        switch event {
          case let .success(response):
            let str = String(decoding: response.data, as: UTF8.self)
            if let promotion = Mapper<Promotion>().mapArray(JSONString: str) {
              observe.onNext(promotion)
            } else {
              let error = NSError(domain: "com.congtung.pizza", code: 1, userInfo: ["message": "Can't decode promotion"])
              observe.onError(error)
            }
          case let .error(error):
            observe.onError(error)
        }
      }
    }
    
  }
}
