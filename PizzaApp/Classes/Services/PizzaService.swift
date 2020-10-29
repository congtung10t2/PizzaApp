//
//  PizzaService.swift
//  PizzaApp
//
//  Created by CongTung on 1/2/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import ObjectMapper

class PizzaService {
  
  static let shared = PizzaService()
  
  func getPizza(success: @escaping (Int, [Pizza]) -> (), failure: @escaping (Int) -> ()) {
    
    APIClient.shared.getArray(urlString: Endpoints.Pizza,
                              success:
                                { (code, arrayOfPizza) in
                                  success(code, arrayOfPizza)
                                })
    { code in
      failure(code)
    }
  }
  
  func getPromotion(success: @escaping (Int, [Promotion]) -> (), failure: @escaping (Int) -> ()) {
    
    APIClient.shared.getArray(urlString: Endpoints.Promotion,
                              success:
                                { (code, arrayOfPromotion) in
                                  success(code, arrayOfPromotion)
                                })
    { code in
      failure(code)
    }
  }
}
