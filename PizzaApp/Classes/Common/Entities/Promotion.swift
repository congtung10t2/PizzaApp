//
//  Promotion.swift
//  PizzaApp
//
//  Created by TungImac on 10/29/20.
//  Copyright © 2020 TungImac. All rights reserved.
//

import ObjectMapper

struct Promotion: Mappable {
  
  var desc: String?
  var image: String?
  
  init?(map: Map) {}
  
  mutating func mapping(map: Map) {
    desc          <- map["desc"]
    image         <- map["image"]
  }
}
