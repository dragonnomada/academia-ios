//
//  FrutasAddViewController.swift
//  70101_FrutApp_VIPER
//
//  Created by Dragon on 16/01/23.
//

import UIKit

class FrutasAddViewController: UIViewController {

    weak var presenter: FrutasAddPresenter?
    
    @IBOutlet weak var imagenImageView: UIImageView!
    
    @IBOutlet weak var nombreTextField: UITextField!
    
    @IBOutlet weak var cantidadTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cargarImagenAction() {
        
        // TODO: Cargar imagen
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        
        self.present(imagePickerController, animated: true)
        
    }
    
    @IBAction func agregarAction() {
        
        guard let nombre = self.nombreTextField.text else {
            return
        }
        
        guard let cantidadText = self.cantidadTextField.text else {
            return
        }
        
        guard let cantidad = Double(cantidadText) else {
            return
        }
        
        guard let imagen = self.imagenImageView.image else {
            return
        }
        
        self.presenter?.agregarFruta(nombre: nombre, cantidad: cantidad, imagen: imagen.pngData())
        
    }

}

extension FrutasAddViewController: FrutasAddView {
    
    func frutas(frutaAgregada fruta: FrutaEntity) {
        
        self.presenter?.cerrarAddFruta()
        
    }
    
}

extension FrutasAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            
            self.imagenImageView.image = image
            
            picker.dismiss(animated: true)
            
        }
        
    }
    
}
