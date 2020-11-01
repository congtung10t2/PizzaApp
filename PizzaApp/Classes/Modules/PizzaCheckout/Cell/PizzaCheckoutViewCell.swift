//
//  PizzaCheckoutViewCell.swift
//  PizzaApp
//
//  Created by TungImac on 11/1/20.
//  Copyright © 2020 TungImac. All rights reserved.
//
import Foundation
import UIKit
import RxSwift
import RxCocoa

class PizzaCheckoutViewCell: UITableViewCell {
  var disposeBag: DisposeBag? = DisposeBag()
  var pizza: Pizza?
  func setup(pizza: Pizza, count: Int) {
    self.pizza = pizza
    if let image = pizza.image {
      productImageView.image = ImageDataService.shared.convertToUIImage(from: image)
    }
    titleLabel.text = pizza.title ?? ""
    priceLabel.text = "\(pizza.price * Double(count)) usd"
  }
  
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var priceLabel: UILabel!
  @IBOutlet private weak var productImageView: UIImageView!
  @IBOutlet weak var closeButton: UIButton!
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
  }

  

  override func awakeFromNib() {
    super.awakeFromNib()
    contentView.isUserInteractionEnabled = false
  }
}
