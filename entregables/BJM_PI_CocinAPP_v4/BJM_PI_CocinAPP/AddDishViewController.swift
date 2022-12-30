//
//  AddDishViewController.swift
//  BJM_PI_v1
//
//  Created by User on 28/12/22.
//

import UIKit

class AddDishViewController: UIViewController {
    
    @IBOutlet weak var availableDishesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        availableDishesTableView.dataSource = self
        availableDishesTableView.delegate = self
    }

}

extension AddDishViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Elige Platillos a Ordenar"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AvailableDish.shared.getDishesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addDishCell")!
        
        if let dish = AvailableDish.shared.getDish(index: indexPath.row) {
            var config = cell.defaultContentConfiguration()
            config.text = dish.nombre
            
            cell.contentConfiguration = config
        }
        
        return cell
    }
    
}

extension AddDishViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if let dish = AvailableDish.shared.getDish(index: indexPath.row) {
            
            OrderManager.shared.addDishToCurrentOrder(dish.nombre)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
