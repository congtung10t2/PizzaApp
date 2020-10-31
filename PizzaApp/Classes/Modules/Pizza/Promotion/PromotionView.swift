//
//  PromotionView.swift
//  PizzaApp
//
//  Created by TungImac on 10/31/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SnapKit
class PromotionView: UIView, NibInstantiatable {
  @IBOutlet private weak var collectionView: UICollectionView!
  @IBOutlet private weak var pageControl: UIPageControl!
  private var interactor = PromotionInteractor()
  let disposeBag = DisposeBag()
  override func awakeFromNib() {
      super.awakeFromNib()
    interactor.loadPromotion()
    collectionView.register(PromotionViewCell.self, forCellWithReuseIdentifier: "PromotionViewCell")
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    layout.scrollDirection = .horizontal
    layout.itemSize = CGSize(width: self.frame.width, height: self.frame.height)
    collectionView.collectionViewLayout = layout
    interactor.promotionRelay.subscribe(onNext: { [self] value in
      pageControl.numberOfPages = value.count
      self.collectionView.reloadData()
    }).disposed(by: disposeBag)
  }
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
  }
}

extension PromotionView: UICollectionViewDataSource, UICollectionViewDelegate {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    interactor.promotionRelay.value.count
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 1
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let offSet = scrollView.contentOffset.x
      let width = scrollView.frame.width
      let horizontalCenter = width / 2

      pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromotionViewCell", for: indexPath)
    if let image = interactor.promotionRelay.value[indexPath.section].image {
      let imageView = UIImageView(frame: self.frame)
      imageView.image = ImageDataService.shared.convertToUIImage(from: image)
      cell.addSubview(imageView)
      imageView.snp.makeConstraints { make in
        make.leading.equalToSuperview()
        make.top.equalToSuperview()
        make.trailing.equalToSuperview()
        make.bottom.equalToSuperview()
      }
      cell.clipsToBounds = true
    }
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    self.frame.size
  }

}
