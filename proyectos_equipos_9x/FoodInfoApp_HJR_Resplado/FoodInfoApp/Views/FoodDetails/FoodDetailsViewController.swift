//
//  FoodDetailsViewController.swift
//  FoodInfoApp
//
//  Created by MacBook on 27/01/23.
//

import UIKit

class FoodDetailsViewController: UIViewController {
    
    weak var presenter: FoodDetailsPresenter?
    
    var foodSelected: FoodEntity?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FoodDetailsViewController: FoodDetailsDelegate {
    
    func food(foodSelected food: FoodEntity) {
        self.foodSelected = food
    }
    
    
}
