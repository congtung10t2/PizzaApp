//
//  PromotionViewCell.swift
//  PizzaApp
//
//  Created by TungImac on 10/31/20.
//  Copyright © 2020 TungImac. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class PromotionViewCell: UICollectionViewCell {
  override func prepareForReuse() {
    super.prepareForReuse()
    for subview in self.contentView.subviews {
         subview.removeFromSuperview()
    }
  }
  
  func configurate(name: String) {
    let imageView = UIImageView(frame: self.frame)
    imageView.image = ImageDataService.shared.convertToUIImage(from: name)
    imageView.contentMode = .scaleToFill
    self.addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.top.equalToSuperview()
      make.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }
}
