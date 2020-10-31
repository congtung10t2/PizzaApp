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
    self.view.backgroundColor = .white
    
    self.view.addSubview(characterImageView)
    self.view.addSubview(pizzaLabel)
    
    let widthHeightConstant = self.view.frame.width * 0.8
    characterImageView.translatesAutoresizingMaskIntoConstraints = false
    characterImageView.widthAnchor.constraint(equalToConstant: widthHeightConstant)
      .isActive = true
    characterImageView.heightAnchor.constraint(equalToConstant: widthHeightConstant)
      .isActive = true
    characterImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
      .isActive = true
    characterImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
      .isActive = true
    pizzaLabel.translatesAutoresizingMaskIntoConstraints = false
    pizzaLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor)
      .isActive = true
    pizzaLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor)
      .isActive = true
    pizzaLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
      .isActive = true
  }
  
}
