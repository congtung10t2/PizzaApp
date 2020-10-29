//
//  APIClient.swift
//  PizzaApp
//
//  Created by CongTung on 1/2/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import Foundation
import ObjectMapper

class APIClient {
  
  static let shared = APIClient()
  
  func getArray<T>(urlString: String,
                   success: @escaping (Int, [T]) -> (),
                   failure: @escaping (Int) -> ()) where T: BaseMappable {
    let bundle = Bundle(for: type(of: self))
    if let path = bundle.path(forResource: urlString, ofType: "json") {
      if let content = try? String(contentsOfFile: path, encoding: String.Encoding.utf8) {
        if let result = Mapper<T>().mapArray(JSONString: content) {
          success(200, result)
        } else {
          failure(400)
        }
      }
    } else {
      failure(404)
    }
  }
  
}
