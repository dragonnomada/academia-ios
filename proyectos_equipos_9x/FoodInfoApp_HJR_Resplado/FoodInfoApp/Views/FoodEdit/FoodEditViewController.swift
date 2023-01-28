//
//  FoodEditViewController.swift
//  FoodInfoApp
//
//  Created by MacBook on 27/01/23.
//

import UIKit

class FoodEditViewController: UIViewController {
    
    weak var presenter: FoodEditPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FoodEditViewController: FoodEditDelegate {
    
    func food(foodEdited food: FoodEntity) {
        print("hjhjh")
    }
}
