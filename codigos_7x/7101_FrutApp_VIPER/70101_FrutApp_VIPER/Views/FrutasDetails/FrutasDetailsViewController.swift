//
//  FrutasDetailsViewController.swift
//  70101_FrutApp_VIPER
//
//  Created by Dragon on 16/01/23.
//

import UIKit

class FrutasDetailsViewController: UIViewController {

    weak var presenter: FrutasDetailsPresenter?
    
    @IBOutlet weak var imagenImageView: UIImageView!
    
    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var cantidadLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.presenter?.reloadFrutaSeleccionada()
        
    }
    
    @IBAction func editFrutaAction() {
        
        self.presenter?.irEditarFruta()
        
    }
}

extension FrutasDetailsViewController: FrutasDetailsView {
    
    func frutas(frutaSeleccionada fruta: FrutaEntity) {
        
        if let imagen = fruta.imagen {
            
            imagenImageView.image = UIImage(data: imagen)
            
        }
        
        self.nombreLabel.text = fruta.nombre
        self.cantidadLabel.text = "\(fruta.cantidad) KG"
        
    }
    
}
