//
//  PromotionView.swift
//  PizzaApp
//
//  Created by TungImac on 10/31/20.
//  Copyright © 2020 TungImac. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SnapKit
import RxCocoa

class PromotionView: UIView, NibInstantiatable {
  @IBOutlet private weak var collectionView: UICollectionView!
  @IBOutlet private weak var pageControl: UIPageControl!
  private var interactor = PromotionInteractor()
  public var scrollingValue = BehaviorRelay<CGFloat>(value: 0)
  let disposeBag = DisposeBag()
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  func setupUI() {
    scrollingValue.bind(to: self.rx.alpha).disposed(by: disposeBag)
    scrollingValue.subscribe(onNext: { value in
      self.pageControl.isHidden = value < 0.9
    }).disposed(by: disposeBag)
    interactor.loadPromotion()
    collectionView.register(PromotionViewCell.self, forCellWithReuseIdentifier: "PromotionViewCell")
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    layout.scrollDirection = .horizontal
    
    
    collectionView.collectionViewLayout = layout
    interactor.promotionRelay.subscribe(onNext: { [self] value in
      pageControl.numberOfPages = value.count
      self.collectionView.reloadData()
    }).disposed(by: disposeBag)
    self.pageControl.isHidden = false
    collectionView.snp.makeConstraints { make in
      make.bottom.top.left.right.equalToSuperview()
      layout.itemSize = CGSize(width: self.frame.width, height: self.frame.height)
    }
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
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromotionViewCell", for: indexPath) as! PromotionViewCell
    if let image = interactor.promotionRelay.value[indexPath.section].image {
      cell.configurate(name: image)
    }
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    collectionView.frame.size
  }
}
