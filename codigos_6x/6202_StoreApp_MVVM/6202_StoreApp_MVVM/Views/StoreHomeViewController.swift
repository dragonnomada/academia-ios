//
//  StoreHomeViewController.swift
//  6202_StoreApp_MVVM
//
//  Created by Dragon on 10/01/23.
//

import UIKit

class StoreHomeViewController: UIViewController {

    @IBOutlet weak var fruitsTableView: UITableView!
    
    var viewModel = StoreHomeViewModel()
    
    var fruits: [FruitEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.view = self

        //self.fruitsTableView.register(UINib(nibName: self.nibName!, bundle: self.nibBundle), forCellReuseIdentifier: "FruitCell")
        
        self.fruitsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "FruitCell")
        
        self.fruitsTableView.dataSource = self
        self.fruitsTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.getFruits()
    }
    
    /*override func viewWillDisappear(_ animated: Bool) {
        self.viewModel.view = nil
    }*/
    
    @IBAction func fruitAddAction() {
        self.navigationController?.pushViewController(StoreAddViewController(), animated: true)
    }

}

extension StoreHomeViewController: StoreHomeView {
    
    func fruits(fruitsUptated fruits: [FruitEntity]) {
        self.fruits = fruits
        self.fruitsTableView.reloadData()
    }
    
    func fruits(fruitSelected fruit: FruitEntity) {
        print("Fruta seleccionada: \(fruit.name ?? "SIN NOMBRE") [\(fruit.amount) kg]")
        //self.navigationController?.pushViewController(StoreDetailsViewController(), animated: true)
    }
    
}

extension StoreHomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Frutas"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.fruitsTableView.dequeueReusableCell(withIdentifier: "FruitCell")!
        
        //print("Pintando celda \(cell)")
        
        var config = cell.defaultContentConfiguration()
        
        let fruit = self.fruits[indexPath.row]
        
        config.text = fruit.name
        config.secondaryText = "\(fruit.amount) kg"
        
        cell.contentConfiguration = config
        
        return cell
    }
    
}

extension StoreHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.viewModel.selectFruit(index: indexPath.row)
        
    }
    
}
