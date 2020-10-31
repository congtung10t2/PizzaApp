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

class PizzaViewController: UIViewController {
  
  // MARK: - Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    
    presenter?.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = true
  }
  // MARK: - Actions
  @objc func refresh() {
    presenter?.refresh()
  }
  
  // MARK: - Properties
  var presenter: ViewToPresenterPizzaProtocol?
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.rowHeight = 400
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
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter?.didSelectRowAt(index: indexPath.row)
    presenter?.deselectRowAt(index: indexPath.row)
  }
}

// MARK: - UI Setup
extension PizzaViewController {
  func setupUI() {
    overrideUserInterfaceStyle = .light
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.barTintColor = .black
    self.view.addSubview(tableView)
    tableView.addSubview(refreshControl)
    let parentView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 400))
    tableView.parallaxHeader.view = parentView
    tableView.parallaxHeader.height = 300
    tableView.parallaxHeader.minimumHeight = 0
    tableView.parallaxHeader.mode = .topFill
    let promotionView = PromotionView.fromNib()
    parentView.blurView.setup(style: UIBlurEffect.Style.dark, alpha: 1).enable()
  
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
    tableView.snp.makeConstraints { make in
      make.bottom.equalToSuperview()
      make.top.equalToSuperview()
      make.left.equalToSuperview()
      make.right.equalToSuperview()
    }
    tableView.register(PizzaViewCell.self)
  }
  override var prefersStatusBarHidden: Bool {
      return true
  }
}
