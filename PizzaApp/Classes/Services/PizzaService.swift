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
      let request = self.provider.request(.pizza) { result in
        switch result {
          case let .success(moyaResponse):
            do {
              let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
              let str = String(decoding: filteredResponse.data, as: UTF8.self)
              if let pizza = Mapper<Pizza>().mapArray(JSONString: str) {
                observe.onNext(pizza)
              } else {
                let error = NSError(domain: "com.congtung.pizza", code: 1, userInfo: ["message": "error"])
                observe.onError(error)
              }
            }
            catch let error {
              observe.onError(error)
            }
          case let .failure(error):
            observe.onError(error)
        }
      }
      return Disposables.create {
        request.cancel()
      }
      
    }
  }
  func getPromotion() -> Observable<[Promotion]> {
    return Observable.create { observe in
      let request = self.provider.request(.promotion) { result in
        switch result {
          case let .success(moyaResponse):
            do {
              let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
              let str = String(decoding: filteredResponse.data, as: UTF8.self)
              if let promotion = Mapper<Promotion>().mapArray(JSONString: str) {
                observe.onNext(promotion)
              } else {
                let error = NSError(domain: "com.congtung.pizza", code: 1, userInfo: ["message": "error"])
                observe.onError(error)
              }
              
            }
            catch let error {
              observe.onError(error)
            }
          case let .failure(error):
            observe.onError(error)
        }
      }
      return Disposables.create {
        request.cancel()
      }
    }
    
  }
}
