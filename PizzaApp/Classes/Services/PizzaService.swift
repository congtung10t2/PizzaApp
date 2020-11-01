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
  
  func getPizza(success: @escaping (Int, [Pizza]) -> (), failure: @escaping (Int) -> ()) {
    
    provider.request(.pizza) { result in
      switch result {
        case let .success(moyaResponse):
          do {
            let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
            let str = String(decoding: filteredResponse.data, as: UTF8.self)
            let pizza = Mapper<Pizza>().mapArray(JSONString: str)
            success(200, pizza!)
          }
          catch let error {
            print(error)
          }
        case let .failure(error):
          print(error)
      }
    }
  }
  func getPromotion(success: @escaping (Int, [Promotion]) -> (), failure: @escaping (Int) -> ()) {
    
    provider.request(.promotion) { result in
      switch result {
        case let .success(moyaResponse):
          do {
            let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
            let str = String(decoding: filteredResponse.data, as: UTF8.self)
            if let promotion = Mapper<Promotion>().mapArray(JSONString: str) {
              success(200, promotion)
            }
            
          }
          catch let error {
            failure(error.asAFError?.responseCode ?? 404)
          }
        case let .failure(error):
          failure(error.asAFError?.responseCode ?? 400)
      }
    }
  }
}
