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
    refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
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
    self.view.addSubview(tableView)
    tableView.addSubview(refreshControl)
    tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 400))
    let promotionView = PromotionView.fromNib()
    tableView.tableHeaderView?.addSubview(promotionView)
    promotionView.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.top.equalToSuperview()
      make.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
    }
    tableView.tableHeaderView?.backgroundColor = .red
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    tableView.register(PizzaViewCell.self)
  }
}
