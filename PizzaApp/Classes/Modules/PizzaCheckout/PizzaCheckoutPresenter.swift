//
//  PizzaCheckoutPresenter.swift
//  PizzaApp
//
//  Created TungImac on 11/1/20.
//  Copyright © 2020 TungImac. All rights reserved.
//

import UIKit

class PizzaCheckoutPresenter: PizzaCheckoutPresenterProtocol {

    weak private var view: PizzaCheckoutViewProtocol?
    var interactor: PizzaCheckoutInteractorProtocol?
    private let router: PizzaCheckoutWireframeProtocol

    init(interface: PizzaCheckoutViewProtocol, interactor: PizzaCheckoutInteractorProtocol?, router: PizzaCheckoutWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
