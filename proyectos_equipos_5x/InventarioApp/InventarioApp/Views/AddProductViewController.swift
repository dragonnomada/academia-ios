//
//  AddViewController.swift
//  InventarioApp
//
//  Created by MacBook  on 05/01/23.
//

import UIKit

class AddProductViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addProductImage: UIImageView!
    @IBOutlet weak var addProductName: UITextField!
    @IBOutlet weak var addProductDescripcion: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        InventarioController.shared.inventarioAddProductDelegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func AddImage(_ sender: Any) {
        let alert = UIAlertController(title: "Selcciona una imagen", message: "¿Desde donde quieres seleccionar imagen?", preferredStyle: .alert)
        
        let camaraBoton = UIAlertAction(title: "Camara", style: .destructive) { _ in
            self.mostrarImagenSeleccionada(imagenSeleccionada: .camera)
        }
        
        let bibliotecaBoton = UIAlertAction(title: "Biblioteca", style: .default) { _ in
            self.mostrarImagenSeleccionada(imagenSeleccionada: .photoLibrary)
        }
        
        let cancelBotton = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(camaraBoton)
        alert.addAction(bibliotecaBoton)
        alert.addAction(cancelBotton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func mostrarImagenSeleccionada(imagenSeleccionada: UIImagePickerController.SourceType){
        
        guard UIImagePickerController.isSourceTypeAvailable(imagenSeleccionada) else {
            print("Data Source no disponible")
            return
        }
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = imagenSeleccionada
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true,completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let image =  info[.originalImage] as? UIImage {
            addProductImage.image = image
        } else {
            print("Imagen no encontrada")
        }
        picker.dismiss(animated: true, completion: nil)
            
    }
    
    @IBAction func cancelar(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func agregar(_ sender: Any) {
        guard let nombre = addProductName.text else { return }
        guard let descripcion = addProductDescripcion.text else { return }
        guard let imagen = addProductImage.image?.pngData() else { return }
        
        InventarioController.shared.addProduct(nombre: nombre, imagen: imagen, descripcion: descripcion)
    }

}

extension AddProductViewController: InventarioAddProductDelegate {
    func inventario(productAdded producto: ProductoEntity) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func inventario(addProductError error: String) {
        self.present(UIAlertController.simpleErrorAlert(message: error), animated: true)
    }
    
    
}
