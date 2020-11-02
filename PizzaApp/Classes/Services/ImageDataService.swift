//
//  ImageDataService.swift
//  PizzaApp
//
//  Created by CongTung on 1/3/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class ImageDataService {
  static let shared = { ImageDataService() }()
  let provider = MoyaProvider<MoyaService>(stubClosure: MoyaProvider.immediatelyStub)
  func convertToUIImage(from name: String) -> Observable<UIImage> {
    
    return Observable.create { observe in
      return self.provider.rx.request(.image(param: name)).subscribe { event in
        switch event {
          case let .success(response):
            if let image = UIImage(data: response.data) {
              observe.onNext(image)
            } else {
              let error = NSError(domain: "com.congtung.pizza", code: 1, userInfo: ["message": "Can't decode to UIImage"])
              observe.onError(error)
            }
          case let .error(error):
            observe.onError(error)
        }
        
      }
      
    }
  }

}
