//
//  FoodDetailsDelegate.swift
//  FoodInfoApp
//
//  Created by MacBook on 27/01/23.
//

import Foundation
import UIKit

protocol FoodDetailsDelegate: UIViewController {
    
    var presenter: FoodDetailsPresenter? { get set }
    
    func viewWillCreate()
    
    func viewDidCreate()
    
    func viewWillRemove()
    
    func food(foodSelected food: FoodEntity)
    
    func todos(todoSelectError error: FoodServiceError)
    
}

extension FoodDetailsDelegate {
    
    func viewWillCreate() {}
    
    func viewDidCreate() {}
    
    func viewWillRemove() {}
    
    func todos(todoSelectError error: FoodServiceError) {
        
        var message = "Undefined"
        
        switch error {
            
        case .selectFood(let id):
            message = "Food select error with id: \(id)"
            
        default:
            message = "\(error)"
            
        }
        
        let alert = UIAlertController(title: "Food select error", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        self.present(alert, animated: true)
        
    }
    
}
