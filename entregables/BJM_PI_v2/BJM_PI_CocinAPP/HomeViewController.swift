//
//  HomeViewController.swift
//  BJM_PI_v1
//
//  Created by User on 28/12/22.
//

import UIKit

struct Dish {
    
    let nombre: String
}

struct Order {
    
    let dishesInOrder = [String: Int]()
}

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createNewOrder(_ sender: Any) {
        performSegue(withIdentifier: "ToAddOrder", sender: nil)
    }
    
    @IBAction func createDish(_ sender: Any) {
        performSegue(withIdentifier: "ToAddNewDish", sender: nil)
    }
    
}

class OrderManager {
    
    static let shared = OrderManager()
    
    var orders: [Order] = []
    
    func getLastNumberOfOrder() -> Int {
        return OrderManager.shared.orders.count + 1
    }
    
    func addDishToOrder() {
        
    }
}

class AvailableDish {
    
    static let shared = AvailableDish()
    
    var availableDishes: [Dish] = [
        Dish(nombre: "Enchiladas Verdes"),
        Dish(nombre: "Enchiladas Rojas"),
        Dish(nombre: "Enchiladas Suizas"),
        Dish(nombre: "Enchiladas Potosinas")
    ]
    
    func addNewDish(_ newDish: Dish) {
        AvailableDish.shared.availableDishes.append(newDish)
    }
    
    func getDishesCount() -> Int {
        return AvailableDish.shared.availableDishes.count
    }
    
    func getDish(index: Int) -> Dish? {
        if index >= 0 && index < AvailableDish.shared.availableDishes.count {
            return AvailableDish.shared.availableDishes[index]
        } else {
            return nil
        }
    }
}
