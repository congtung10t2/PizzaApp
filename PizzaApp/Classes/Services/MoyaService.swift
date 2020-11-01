//
//  MoyaService.swift
//  PizzaApp
//
//  Created by TungImac on 11/1/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import Foundation
import Moya
enum MoyaService: String {
  case pizza
  case promotion
}
extension MoyaService: TargetType {
  var baseURL: URL { return URL(string: "https://api.congtung.com")! }
  var path: String {
    return self.rawValue
  }
  var method: Moya.Method {
    return .get
  }
  var task: Task {
    return .requestPlain
  }
  var sampleData: Data {
    switch self {
      case .pizza:
        guard let url = Bundle.main.url(forResource: "pizza", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
          return Data()
        }
        return data
      case .promotion:
        // Provided you have a file named accounts.json in your bundle.
        guard let url = Bundle.main.url(forResource: "promotion", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
          return Data()
        }
        return data
    }
  }
  var headers: [String: String]? {
    return ["Content-type": "application/json"]
  }
}
// MARK: - Helpers
private extension String {
  var urlEscaped: String {
    return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }
  
  var utf8Encoded: Data {
    return data(using: .utf8)!
  }
}
