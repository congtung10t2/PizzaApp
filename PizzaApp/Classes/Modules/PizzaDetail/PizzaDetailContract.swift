//
//  PizzaDetailContract.swift
//  PizzaApp
//
//  Created by CongTung on 1/2/20.
//  Copyright © 2020 CongTung. All rights reserved.
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewPizzaDetailProtocol: class {
    
    func onGetImageFromURLSuccess(_ desc: String, image: UIImage)
    func onGetImageFromURLFailure(_ desc: String)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterPizzaDetailProtocol: class {
    
    var view: PresenterToViewPizzaDetailProtocol? { get set }
    var interactor: PresenterToInteractorPizzaDetailProtocol? { get set }
    var router: PresenterToRouterPizzaDetailProtocol? { get set }

    func viewDidLoad()
    
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorPizzaDetailProtocol: class {
    
    var presenter: InteractorToPresenterPizzaDetailProtocol? { get set }
    
    var pizza: Pizza? { get set }
    
    func getImageData()
    
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterPizzaDetailProtocol: class {
    
    func getImageFromURLSuccess(pizza: Pizza, image: UIImage)
    func getImageFromURLFailure(pizza: Pizza)
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterPizzaDetailProtocol: class {
    
    static func createModule(with Pizza: Pizza) -> UIViewController
}
