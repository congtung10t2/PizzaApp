//
//  PizzaCheckoutViewController.swift
//  PizzaApp
//
//  Created TungImac on 11/1/20.
//  Copyright © 2020 TungImac. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class PizzaCheckoutViewController: UIViewController, PizzaCheckoutViewProtocol {
  
  var presenter: PizzaCheckoutPresenterProtocol?
  var items = BehaviorRelay<[Pizza: Int]>(value: [:])
  let disposeBag = DisposeBag()
  var deliveryLabel: UILabel = UILabel()
  @IBOutlet private weak var tableView: UITableView!
  var valueLabel: UILabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  func getSelectedItem(indexPath: IndexPath) -> Pizza {
    items.value.map { $0.key }[indexPath.row]
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  func setupUI() {
    tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 150))
    tableView.snp.makeConstraints { make in
      make.top.left.right.equalToSuperview()
      make.height.equalTo((items.value.count + 1) * 60 + 150)
    }
    addLabelDelivery()
    addLabelValue()
    addButtonPayment()
    tableView.register(PizzaCheckoutViewCell.self)
    items.flatMapLatest { element -> Observable<[Pizza]> in
      Observable.just(element.map({ $0.key }))
    }.bind(to: tableView.rx.items(cellIdentifier: PizzaCheckoutViewCell.identifier, cellType: PizzaCheckoutViewCell.self)) { index, model, cell in
      cell.setup(pizza: model, count: self.items.value[model] ?? 1)
    }.disposed(by: disposeBag)
    tableView.rx.itemSelected.asDriver().drive(onNext: { indexPath in
      var items = self.items.value
      items.removeValue(forKey: self.getSelectedItem(indexPath: indexPath))
      self.items.accept(items)
      self.updateValuePrice()
    }).disposed(by: disposeBag)
    navigationController?.setNavigationBarHidden(false, animated: false)
    navigationController?.title = "Checkout information"
    overrideUserInterfaceStyle = .light
  }
  func addLabelDelivery() {
    deliveryLabel.text = "Delivery is free"
    deliveryLabel.textColor = .gray
    tableView.tableFooterView?.addSubview(deliveryLabel)
    deliveryLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.left.equalToSuperview().offset(20)
    }
  }
  func addButtonPayment() {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    button.setBackgroundImage(#imageLiteral(resourceName: "ic-payment"), for: .normal)
    self.view.addSubview(button)
    button.snp.makeConstraints { make in
      make.width.equalTo(40)
      make.height.equalTo(40)
      make.bottom.equalTo(self.view.snp.bottom).offset(-20)
      make.right.equalTo(self.view.snp.right).offset(-20)
    }
    button.rx.tap.subscribe({ [weak self] _ in
      self?.showAlert(title: "Pizza Apps", message: "Payment will be implement later!")
    }).disposed(by: disposeBag)
  }
  
  func getPriceTotal()-> String {
    let sum = items.value.reduce(0.0, { x, y in
      x + (y.key.price * Double(y.value))
    })
    return "\(sum) usd"
  }
  
  func updateValuePrice() {
    let myString = "Value: \(getPriceTotal())"
    let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular) ]
    let myAttrString = NSMutableAttributedString(string: myString, attributes: myAttribute)
    let smallString = "Value: "
    myAttrString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 17, weight: .bold), range: NSRange(location: smallString.count,length: myString.count - smallString.count))
    
    // set attributed text on a UILabel
    valueLabel.attributedText = myAttrString
  }
  
  func addLabelValue() {
    // create attributed string
    updateValuePrice()
    tableView.tableFooterView?.addSubview(valueLabel)
    valueLabel.snp.makeConstraints { make in
      make.top.equalTo(deliveryLabel.snp.bottom).offset(10)
      make.left.equalTo(deliveryLabel.snp.left)
    }
    
  }
}
