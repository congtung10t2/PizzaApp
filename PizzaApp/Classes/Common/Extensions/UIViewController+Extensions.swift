//
//  UIViewController+Extensions.swift
//  PizzaApp
//
//  Created by TungImac on 11/1/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

extension UIViewController {
  func showAlert(title: String, message : String) {
      DispatchQueue.main.async(execute: {
        let alertController = UIAlertController(title: title, message:
          message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
      })
    }
    
}
