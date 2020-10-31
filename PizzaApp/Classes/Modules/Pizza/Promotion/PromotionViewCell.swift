//
//  PromotionViewCell.swift
//  PizzaApp
//
//  Created by TungImac on 10/31/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import Foundation
import UIKit
class PromotionViewCell: UICollectionViewCell {
  override func prepareForReuse() {
    super.prepareForReuse()
    for subview in self.contentView.subviews {
         subview.removeFromSuperview()
    }
  }
}
