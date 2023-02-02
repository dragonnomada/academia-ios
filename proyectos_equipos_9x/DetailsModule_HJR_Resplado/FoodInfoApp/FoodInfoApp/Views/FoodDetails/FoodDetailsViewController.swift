//
//  FoodDetailsViewController.swift
//  FoodInfoApp
//
//  Created by MacBook on 27/01/23.
// camera.macro

import UIKit

class FoodDetailsViewController: UIViewController {
    
    weak var presenter: FoodDetailsPresenter?
    
    var foodSelected: FoodEntity?
    var foodUpdated: FoodEntity?
    let defaultImage = UIImage.init(systemName: "pencil")?.pngData()
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var nameFoodLabel: UILabel!
    @IBOutlet weak var nutrientsLabel: UILabel!
    @IBOutlet weak var caloriesCountLabel: UILabel!
    @IBOutlet weak var fatCountLabel: UILabel!
    @IBOutlet weak var sugarCountLabel: UILabel!
    @IBOutlet weak var fiberCountLabel: UILabel!
    @IBOutlet weak var carbsCountLabel: UILabel!
    @IBOutlet weak var proteinCountLabel: UILabel!
    @IBOutlet weak var unitCountLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "Food Details"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.editButtonAction))
        
        //foodImage.layer.cornerRadius = foodImage.bounds.size.width / 5.0
        foodImage.layer.cornerRadius = 9
        foodImage.layer.borderWidth = 5
        foodImage.layer.borderColor = UIColor.blue.cgColor
        
        self.presenter?.requestFoodSelected()
        
    }
    
    @objc func editButtonAction() {
        
        self.presenter?.goToEdit()
        
        /*
        let viewControllerToPresent = FoodEditViewController()
        present(viewControllerToPresent, animated: true, completion: nil)*/
        
    }
}

extension FoodDetailsViewController: FoodDetailsDelegate {
    
    func food(foodSelected food: FoodEntity) {
        
        self.foodSelected = food
        
        nameFoodLabel.text = food.name
        caloriesCountLabel.text = food.calories.description
        fatCountLabel.text = food.fat.description
        sugarCountLabel.text = food.sugar.description
        fiberCountLabel.text = food.fiber.description
        carbsCountLabel.text = food.carbs.description
        proteinCountLabel.text = food.protein.description
        unitCountLabel.text = food.units.description
        self.foodImage.image = UIImage(data: food.image ?? defaultImage!)
        
    }
    
    func food(foodUpdated food: FoodEntity) {
        
        self.foodUpdated = food
        
        nameFoodLabel.text = food.name
        caloriesCountLabel.text = food.calories.description
        fatCountLabel.text = food.fat.description
        sugarCountLabel.text = food.sugar.description
        fiberCountLabel.text = food.fiber.description
        carbsCountLabel.text = food.carbs.description
        proteinCountLabel.text = food.protein.description
        unitCountLabel.text = food.units.description
        self.foodImage.image = UIImage(data: food.image ?? defaultImage!)
        
    }
    
}
