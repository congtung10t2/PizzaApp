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
import RxCocoa

protocol PizzaCellPresenter {
  func setup(pizza: Pizza)
}

class PizzaViewCell: UITableViewCell, PizzaCellPresenter {
  public var onTapAdd = PublishSubject<Void>()
  var disposeBag: DisposeBag? = DisposeBag()
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var descLabel: UILabel!
  @IBOutlet private weak var quantityLabel: UILabel!
  @IBOutlet private weak var productImageView: UIImageView!
  @IBOutlet private weak var priceButton: UIButton!
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      
  }
  override func prepareForReuse() {
    super.prepareForReuse()
    disposeBag = nil
    disposeBag = DisposeBag()
  }
  
  @IBAction func onAddButton(_ sender: Any) {
    onTapAdd.onNext(())
  }
  override func awakeFromNib() {
      super.awakeFromNib()
  }
  func setup(pizza: Pizza) {
    titleLabel.text = pizza.title
    descLabel.text = pizza.desc
    quantityLabel.text = "100gram, 2 pieces"
    priceButton.setTitle(pizza.priceString, for: .normal)
    priceButton.setTitle("added +1", for: .selected)
    priceButton.setBackgroundColor(color: .green, forState: .highlighted)
    priceButton.setBackgroundColor(color: .green, forState: .selected)
    priceButton.setBackgroundColor(color: .black, forState: .normal)
    guard let image = pizza.image else { return }
    productImageView.image = ImageDataService.shared.convertToUIImage(from: image)
    self.contentView.backgroundColor = .clear
    
  }
}


