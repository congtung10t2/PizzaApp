//
//  PizzaDetailViewController.swift
//  PizzaApp
//
//  Created by CongTung on 1/2/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import UIKit

class PizzaDetailViewController: UIViewController {
  
  // MARK: - Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    
    presenter?.viewDidLoad()
  }
  
  // MARK: - Properties
  var presenter: ViewToPresenterPizzaDetailProtocol?
  
  lazy var characterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  lazy var pizzaLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    return label
  }()
  override var prefersStatusBarHidden: Bool {
      return true
  }
}

extension PizzaDetailViewController: PresenterToViewPizzaDetailProtocol {
  func onGetImageFromURLSuccess(_ desc: String, image: UIImage) {
    pizzaLabel.text = desc
    characterImageView.image = image
  }
  
  func onGetImageFromURLFailure(_ desc: String) {
    pizzaLabel.text = desc
  }
  
  func onGetImageFromURLSuccess(_ pizza: String, character: String, image: UIImage) {
    print("View receives the response from Presenter and updates itself.")
    
  }
  
  func onGetImageFromURLFailure(_ pizza: String, character: String) {
    print("View receives the response from Presenter and updates itself.")
    pizzaLabel.text = pizza
    self.navigationItem.title = character
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = false
  }
  
}

// MARK: - UI Setup
extension PizzaDetailViewController {
  func setupUI() {
    overrideUserInterfaceStyle = .light
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.backgroundColor = .clear
    self.view.backgroundColor = .white
    
    self.view.addSubview(characterImageView)
    self.view.addSubview(pizzaLabel)
    characterImageView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(self.view.safeAreaTop)
      make.height.equalTo(300)
      make.right.equalToSuperview()
      make.left.equalToSuperview()
    }
    pizzaLabel.snp.makeConstraints { make in
      make.left.equalTo(self.view.snp.left).offset(20)
      make.top.equalTo(self.characterImageView.snp.bottom).offset(30)
      make.right.equalTo(self.view.snp.right).offset(-20)
    }
  }
  
}
