//
//  NewOrderViewController.swift
//  BJM_PI_v4
//
//  Created by User on 28/12/22.
//

import UIKit

class NewOrderViewController: UIViewController {
    
    @IBOutlet weak var currentOrderLabelView: UILabel!
    
    @IBOutlet weak var currentOrderTableView: UITableView!
    
    @IBAction func createOrderActionButton(_ sender: Any) {
        if OrderManager.shared.currentOrder.dishesInOrder.count > 0 {
       
            OrderManager.shared.addNewOrder(OrderManager.shared.currentOrder)
            self.navigationController?.popViewController(animated: true)
            OrderManager.shared.currentOrder.dishesInOrder.removeAll()
            
        } else {
            let errorAddNewDish = UIAlertController(title: "Error", message: "La orden está vacía.", preferredStyle: .alert)
            errorAddNewDish.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(errorAddNewDish, animated: true)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        currentOrderTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentOrderLabelView.text = "Orden # \(OrderManager.shared.getLastNumberOfOrder())"
        currentOrderTableView.dataSource = self
        currentOrderTableView.delegate = self
    }
    
    @IBAction func addDishToOrder(_ sender: Any) {
        
        performSegue(withIdentifier: "ToAddDishInOrder", sender: nil)
    }
    
}

extension NewOrderViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Platillos Ordenados"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrderManager.shared.getDishesCountForCurrentOrder()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newOrderDishCell")!
        
        if let dish = OrderManager.shared.getDishForCurrentOrder(index: indexPath.row) {
            var config = cell.defaultContentConfiguration()
            
            config.text = "\(dish.platillo.nombre)"
            config.secondaryText = "x \(dish.veces)"
            
            cell.contentConfiguration = config
        }
        
        return cell
    }
    
}

extension NewOrderViewController: UITableViewDelegate {
    
}
