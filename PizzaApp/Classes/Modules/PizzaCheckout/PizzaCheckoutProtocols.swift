//
//  PizzaCheckoutProtocols.swift
//  PizzaApp
//
//  Created TungImac on 11/1/20.
//  Copyright © 2020 TungImac. All rights reserved.
//
//

import Foundation

//MARK: Wireframe -
protocol PizzaCheckoutWireframeProtocol: class {

}
//MARK: Presenter -
protocol PizzaCheckoutPresenterProtocol: class {

}

//MARK: Interactor -
protocol PizzaCheckoutInteractorProtocol: class {

  var presenter: PizzaCheckoutPresenterProtocol?  { get set }
}

//MARK: View -
protocol PizzaCheckoutViewProtocol: class {

  var presenter: PizzaCheckoutPresenterProtocol?  { get set }
}
