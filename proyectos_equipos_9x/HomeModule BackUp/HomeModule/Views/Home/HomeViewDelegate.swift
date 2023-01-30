//
//  HomeViewDelegate.swift
//  HomeModule
//
//  Created by User on 27/01/23.
//

import Foundation
import UIKit

protocol HomeViewDelegate: UIViewController {
    
    var presenter: HomePresenter? { get set }
    
    func viewWillCreate()
    
    func viewDidCreate()
    
    func viewWillRemove()
    
    func foods(foods: [FoodEntity])
    
    func foods(filteredFoods foods: [FoodEntity])
    
    func foods(selectedFood food: FoodEntity)
    
    func foods(selectedFoodError error: FoodServiceError)
    
}

extension HomeViewDelegate {
    
    func viewWillCreate() {}
    
    func viewDidCreate() {}
    
    func viewWillRemove() {}
    
    func foods(selectedFoodError error: FoodServiceError) {
        
        let alert = UIAlertController(title: "Selected Food Error", message: "Index out of bounds for FoodService.foods", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        self.present(alert, animated: true)
        
    }
    
}
