//
//  PizzaViewCell.swift
//  PizzaApp
//
//  Created by TungImac on 10/31/20.
//  Copyright © 2020 TungImac. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol PizzaCellPresenter {
  func setup(pizza: Pizza)
}

class PizzaViewCell: UITableViewCell, PizzaCellPresenter {
  func setup(pizza: Pizza) {
    titleLabel.text = pizza.title
    descLabel.text = pizza.desc
    quantityLabel.text = "100gram, 2 pieces"
    priceButton.setTitle(pizza.priceString, for: .normal)
    
    guard let image = pizza.image else { return }
    productImageView.image = ImageDataService.shared.convertToUIImage(from: image)
  }
  
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var descLabel: UILabel!
  @IBOutlet private weak var quantityLabel: UILabel!
  @IBOutlet private weak var productImageView: UIImageView!
  @IBOutlet private weak var priceButton: UIButton!
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      
  }
  override func awakeFromNib() {
      super.awakeFromNib()
  }
}

