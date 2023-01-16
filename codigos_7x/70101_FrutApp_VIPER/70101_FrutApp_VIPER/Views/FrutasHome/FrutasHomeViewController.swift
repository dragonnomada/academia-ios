//
//  FrutasHomeViewController.swift
//  70101_FrutApp_VIPER
//
//  Created by Dragon on 16/01/23.
//

import UIKit

class FrutasHomeViewController: UIViewController {

    weak var presenter: FrutasHomePresenter?
    
    var frutas: [FrutaEntity] = []
    
    @IBOutlet weak var frutasTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.frutasTableView.dataSource = self
        self.frutasTableView.delegate = self
        
        self.setupNavbarItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.presenter?.recargarFrutas()
        
    }
    
    func setupNavbarItem() {
        
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(self.addFrutaSelector))
        
        self.navigationItem.title = "Frutas Home"
        self.navigationItem.setRightBarButton(addItem, animated: true)
        
    }
    
    @objc func addFrutaSelector() {
        
        print("Solicitando al presenter ir a Agregar Fruta (Desde el ButtonItem)")
        
        self.presenter?.irAgregarFruta()
        
    }
    
    @IBAction func addFrutaAction() {
        
        print("Solicitando al presenter ir a Agregar Fruta (Desde el Button)")
        
        self.presenter?.irAgregarFruta()
        
    }

}

extension FrutasHomeViewController: FrutasHomeView {
    
    func frutas(frutasCargadas frutas: [FrutaEntity]) {
        
        self.frutas = frutas
        
        self.frutasTableView.reloadData()
        
    }
    
    func frutas(frutaSeleccionada fruta: FrutaEntity, index: Int) {
        
        self.presenter?.irDetallesFruta()
        
    }
    
}

extension FrutasHomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Frutas"
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.frutas.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
                
        var config = cell.defaultContentConfiguration()
        
        let index = indexPath.row
        let fruta = self.frutas[index]
        
        config.text = fruta.nombre
        config.secondaryText = "\(fruta.cantidad) KG"
        
        cell.contentConfiguration = config
        
        return cell
        
    }
    
}

extension FrutasHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        
        self.presenter?.seleccionarFruta(index: index)
        
        self.presenter?.irDetallesFruta()
        
    }
    
}
