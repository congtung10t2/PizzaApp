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
import RxSwift

class PromotionViewCell: UICollectionViewCell {
  let disposeBag = DisposeBag()
  override func prepareForReuse() {
    super.prepareForReuse()
    for subview in self.contentView.subviews {
         subview.removeFromSuperview()
    }
  }
  
  func configurate(name: String) {
    let imageView = UIImageView(frame: self.frame)
    ImageDataService.shared.convertToUIImage(from: name).bind(to: imageView.rx.image).disposed(by: disposeBag)
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
