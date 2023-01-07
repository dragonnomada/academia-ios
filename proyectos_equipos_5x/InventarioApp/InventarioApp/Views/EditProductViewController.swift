//
//  EditViewController.swift
//  InventarioApp
//
//  Created by Alan Badillo on 05/01/23.
//

import UIKit

class EditProductViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var editproductImage: UIImageView!
    @IBOutlet weak var editProductName: UITextField!
    @IBOutlet weak var editProductdescripcion: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        InventarioController.shared.inventarioEditProductDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        InventarioController.shared.getSelectedProduct()
    }

    @IBAction func cancelar(_ sender: Any) {
        //
    }
    
    @IBAction func agregar(_ sender: Any) {
        let nombre = editProductName.text
        let imagen = editproductImage.image?.pngData()
        InventarioController.shared.editProduct(nombre: nombre, imagen: imagen, descripcion: editProductdescripcion.text)
    }
    
    @IBAction func editarImage(_sender: Any) {
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
            editproductImage.image = image
        } else {
            print("Imagen no encontrada")
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}

extension EditProductViewController: InventarioEditProductDelegate {
    
    func inventario(productLoaded: ProductoEntity) {
        editProductName.text = productLoaded.nombre
        editProductdescripcion.text = productLoaded.descripcion
        if let img = productLoaded.image {
            editproductImage.image = UIImage(data: img)
        }
    }
    
    func inventario(productEditted: ProductoEntity) {
        print("Producto actualizado")
        self.navigationController?.popViewController(animated: true)
    }
    
    func inventario(editError: String) {
        let alert = UIAlertController(title: "Error", message: editError, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        
        self.present(alert, animated: true)
    }
    
    
}
