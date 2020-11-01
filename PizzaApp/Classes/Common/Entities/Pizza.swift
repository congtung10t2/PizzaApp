//
//  Pizza.swift
//  PizzaApp
//
//  Created by CongTung on 1/2/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import ObjectMapper

struct Pizza: Mappable, Hashable {
  
  var title: String?
  var desc: String?
  var image: String?
  var price: Double = 0
  
  init?(map: Map) {}
  
  mutating func mapping(map: Map) {
    title         <- map["title"]
    desc          <- map["desc"]
    image         <- map["image"]
    price         <- map["price"]
  }
  
}
extension Pizza {
  var priceString: String {
    "\(price) usd"
  }
}
