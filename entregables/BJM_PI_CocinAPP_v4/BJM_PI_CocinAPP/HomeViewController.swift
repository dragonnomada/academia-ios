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
    
    var idOrder: Int
    var dishesInOrder = [(platillo: String, veces: Int)]()
}

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ordersTableView.dataSource = self
        ordersTableView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        ordersTableView.reloadData()
    }
    
    @IBAction func createNewOrder(_ sender: Any) {
        performSegue(withIdentifier: "ToAddOrder", sender: nil)
    }
    
    @IBAction func createDish(_ sender: Any) {
        performSegue(withIdentifier: "ToAddNewDish", sender: nil)
    }
    
    
    @IBOutlet weak var ordersTableView: UITableView!
    
}

class OrderManager {
    
    static let shared = OrderManager()
    
    var orders: [Order] = []
    var currentOrder = Order(idOrder: 0)
    
    func getLastNumberOfOrder() -> Int {
        OrderManager.shared.currentOrder.idOrder = OrderManager.shared.orders.count + 1
        return OrderManager.shared.orders.count + 1
    }
    
    func addDishToCurrentOrder(_ dishName: String) {
        
        var dishExistsInOrder = false
        var index = 0
        
        for dish in OrderManager.shared.currentOrder.dishesInOrder{
            if dishName == dish.0 {
                dishExistsInOrder = true
                break
            }
            index += 1
        }
        
        if dishExistsInOrder {
            OrderManager.shared.currentOrder.dishesInOrder[index].1 += 1
        } else {
            OrderManager.shared.currentOrder.dishesInOrder.append((dishName, 1))
        }
    }
    
    func getDishesCountForCurrentOrder() -> Int {
        return OrderManager.shared.currentOrder.dishesInOrder.count
    }
    
    func getDishForCurrentOrder(index: Int) -> (platillo: String, veces: Int)? {
        if index >= 0 && index < OrderManager.shared.currentOrder.dishesInOrder.count {
            return OrderManager.shared.currentOrder.dishesInOrder[index]
        } else {
            return nil
        }
    }
    
    func addNewOrder(_ newOrder: Order) {
        OrderManager.shared.orders.append(newOrder)
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

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return OrderManager.shared.orders.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Orden #\(OrderManager.shared.orders[section].idOrder)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrderManager.shared.orders[section].dishesInOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderDishCell")!
        
        if OrderManager.shared.orders.count > 0 {
            var config = cell.defaultContentConfiguration()
            config.text = OrderManager.shared.orders[indexPath.section].dishesInOrder[indexPath.row].platillo
            config.secondaryText = "x \(OrderManager.shared.orders[indexPath.section].dishesInOrder[indexPath.row].veces)"
            
            cell.contentConfiguration = config
        }
        
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
}
