//
//  Pizza.swift
//  PizzaApp
//
//  Created by CongTung on 1/2/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import ObjectMapper

struct Pizza: Mappable {
  
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
