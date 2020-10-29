//
//  ImageDataService.swift
//  PizzaApp
//
//  Created by CongTung on 1/3/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import UIKit

class ImageDataService {
  
  static let shared = { ImageDataService() }()
  
  func convertToUIImage(from name: String) -> UIImage {
    return UIImage(imageLiteralResourceName: name)
  }
}
