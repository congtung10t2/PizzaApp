//
//  PizzaViewController.swift
//  PizzaApp
//
//  Created by CongTung on 1/2/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import UIKit
import PKHUD
import SnapKit
import ParallaxHeader
import RxSwift
import RxCocoa

class PizzaViewController: UIViewController {
  let disposeBag = DisposeBag()
  let pizzaQuantity = BehaviorRelay<Int>(value: 0)
  var pizzaMap = [Pizza: Int]()
  // MARK: - Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    presenter?.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
    self.navigationController?.setNavigationBarHidden(true, animated: false)
  }
  // MARK: - Actions
  @objc func refresh() {
    presenter?.refresh()
  }
  
  // MARK: - Properties
  var presenter: ViewToPresenterPizzaProtocol?
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.rowHeight = 450
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self
    return tableView
  }()
  
  lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    return refreshControl
  }()
  
}

extension PizzaViewController: PresenterToViewPizzaProtocol{
  
  func onFetchPizzaSuccess() {
    print("View receives the response from Presenter and updates itself.")
    self.tableView.reloadData()
    self.refreshControl.endRefreshing()
  }
  
  func onFetchPizzaFailure(error: String) {
    print("View receives the response from Presenter with error: \(error)")
    self.refreshControl.endRefreshing()
  }
  
  func showHUD() {
    HUD.show(.progress, onView: self.view)
  }
  
  func hideHUD() {
    HUD.hide()
  }
  
  func deselectRowAt(row: Int) {
    self.tableView.deselectRow(at: IndexPath(row: row, section: 0), animated: true)
  }
  
}

// MARK: - UITableView Delegate & Data Source
extension PizzaViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.numberOfRowsInSection() ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: PizzaViewCell = tableView.dequeueReusableCell(for: indexPath)
    guard let pizza = presenter?.pizzaTitles?[indexPath.row] else { return cell }
    cell.setup(pizza: pizza)
    cell.onTapAdd.throttle(0.5, latest: true, scheduler: MainScheduler.instance).subscribe(onNext: { _ in
      let quantity = self.pizzaQuantity.value + 1
      self.pizzaQuantity.accept(quantity)
      self.pizzaMap.updateValue((self.pizzaMap[pizza] ?? 0) + 1, forKey: pizza)
    }).disposed(by: cell.disposeBag!)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter?.didSelectRowAt(index: indexPath.row)
    presenter?.deselectRowAt(index: indexPath.row)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let bounceLimit: CGFloat = -400.0
    var offset = scrollView.contentOffset;

    if (offset.y < bounceLimit) {
      offset.y = bounceLimit;
      scrollView.contentOffset = offset;
    }

    let offsetY = scrollView.contentSize.height - scrollView.bounds.height - offset.y
    if (offsetY < bounceLimit) {
      offset.y = scrollView.contentOffset.y - (bounceLimit + abs(offsetY));
      scrollView.contentOffset = offset;
    }
  }
}

// MARK: - UI Setup
extension PizzaViewController {
  func setupUI() {
    self.view.addSubview(tableView)
    tableView.addSubview(refreshControl)
    addParalaxheader()
    
    tableView.snp.makeConstraints { make in
      make.bottom.equalToSuperview()
      make.top.equalToSuperview().offset(-self.view.safeAreaTop)
      make.left.equalToSuperview()
      make.right.equalToSuperview()
    }
    tableView.register(PizzaViewCell.self)
    addPizzaButton()
    let backItem = UIBarButtonItem()
    backItem.title = "Menu"
    navigationItem.backBarButtonItem = backItem
    tableView.backgroundColor = .clear
  }
  
  func addPizzaButton() {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    button.setBackgroundImage(#imageLiteral(resourceName: "ic-pizza"), for: .normal)
    self.view.addSubview(button)
    button.snp.makeConstraints { make in
      make.width.equalTo(40)
      make.height.equalTo(40)
      make.bottom.equalTo(self.view.snp.bottom).offset(-20)
      make.right.equalTo(self.view.snp.right).offset(-20)
    }
    let addIcon = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
    addIcon.backgroundColor = .green
    addIcon.cornerRadius = 10
    let addText = UILabel(frame: addIcon.frame)
    addText.text = "0"
    pizzaQuantity.subscribe(onNext: { value in
      addText.text = "\(value)"
    }).disposed(by: disposeBag)
    addText.textAlignment = .center
    addText.textColor = .white
    addIcon.addSubview(addText)
    addText.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.bottom.equalToSuperview()
      make.right.equalToSuperview()
      make.left.equalToSuperview()
    }
    button.addSubview(addIcon)
    button.rx.tap.subscribe({ [weak self] _ in
      guard let self = self else { return }
      self.presenter?.checkOut(pizza: self.pizzaMap)
    }).disposed(by: disposeBag)
    addIcon.snp.makeConstraints { make in
      make.size.equalTo( CGSize(width: 20, height: 20))
      make.top.equalTo(button.snp.top).offset(-10)
      make.right.equalTo(button.snp.right)
      
    }
  }
  
  func addParalaxheader() {
    let parentView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 400))
    parentView.backgroundColor = .clear
    tableView.parallaxHeader.view = parentView
    tableView.parallaxHeader.height = 300
    tableView.parallaxHeader.minimumHeight = 0
    tableView.parallaxHeader.mode = .centerFill
    let promotionView = PromotionView.fromNib()
    parentView.blurView.setup(style: UIBlurEffect.Style.dark, alpha: 1).enable()
    parentView.snp.makeConstraints { make in
      make.top.bottom.right.left.equalToSuperview()
    }
    tableView.parallaxHeader.view.addSubview(promotionView)
    promotionView.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.top.equalToSuperview()
      make.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
    }
    tableView.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
      //update alpha of blur view on top of image view
      promotionView.scrollingValue.accept(parallaxHeader.progress)
    }
    promotionView.alpha = 1
  }
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
