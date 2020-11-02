//
//  MoyaService.swift
//  PizzaApp
//
//  Created by TungImac on 11/1/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import Foundation
import Moya
enum MoyaService {
  case pizza
  case promotion
  case image(param: String)
}
extension MoyaService: TargetType {
  var baseURL: URL { return URL(string: "https://api.congtung.com")! }
  var path: String {
    switch self {
      case .pizza:
        return "pizza"
      case .promotion:
        return "promotion"
      case .image(let param):
        return "images/\(param)"
    }
  }
  
  var method: Moya.Method {
    return .get
  }
  var task: Task {
    switch self {
      case .image(let param):
        return .requestParameters(parameters: ["imageName": param], encoding: URLEncoding.queryString)
      case .promotion:
      return .requestParameters(parameters: ["promotion": "all"], encoding: URLEncoding.queryString)
      default:
        return .requestPlain
    }
    
  }
  var sampleData: Data {
    switch self {
      case .pizza:
        guard let url = Bundle.main.url(forResource: path, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
          return Data()
        }
        return data
      case .promotion:
        guard let url = Bundle.main.url(forResource: path, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
          return Data()
        }
        return data
      case .image(let param):
        return UIImage(imageLiteralResourceName: param).pngData() ?? Data()
        
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
