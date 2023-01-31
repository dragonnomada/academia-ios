//
//  FoodEditDelegate.swift
//  FoodInfoApp
//
//  Created by MacBook on 27/01/23.
//

import Foundation
import UIKit

protocol FoodEditDelegate: UIViewController {
    
    var presenter: FoodEditPresenter? { get set }
    
    func viewWillCreate()
    
    func viewDidCreate()
    
    func viewWillRemove()
    
    func food(foodEdited food: FoodEntity)
    
    func food(foodEditedError error: FoodServiceError)
    
}

extension FoodEditDelegate {
    
    func viewWillCreate() {}
    
    func viewDidCreate() {}
    
    func viewWillRemove() {}
    
    func food(foodEditedError error: FoodServiceError) {
        
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
