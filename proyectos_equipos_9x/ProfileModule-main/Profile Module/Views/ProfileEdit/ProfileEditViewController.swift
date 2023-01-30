//
//  ProfileEditViewController.swift
//  Profile Module
//
//  Created by MacBook Pro on 27/01/23.
//

import UIKit

class ProfileEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak var presenter: ProfileEditPresenter?

    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.requestProfile()
        // Do any additional setup after loading the view.
    }

    @IBAction func selecImageAction(_ sender: Any) {
        
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
        
        
        if let imagenSeleccionada = info[.originalImage] as? UIImage {
            
            self.profileImageView.image = imagenSeleccionada
            
        } else {
            print("Imagen no encontrada")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateAction(_ sender: Any) {
        
        guard self.nameTextField.text != "" else {
            alertEmtyField(typeAlert: "Invalid Name")
            return
        }
        
        
        guard let password = self.passwordTextField.text, password.count >= 6 else {
            alertEmtyField(typeAlert: "Invalid Password")
            return
        }
        
        let data = self.profileImageView.image?.pngData()
        
        self.presenter?.updateProfile(name: self.nameTextField.text, password: self.passwordTextField.text, img: data)
    }
    
    func alertEmtyField(typeAlert: String) {
        let alert = UIAlertController(title: "Alerta \(typeAlert)", message: "\(typeAlert)", preferredStyle: .alert)
                
        alert.addAction(UIAlertAction(title: "Ok", style: .default))

        self.present(alert, animated: true)
    }
}

extension ProfileEditViewController: ProfileEditViewDelegate {
    func profile(profileSelected profile: ProfileEntity) {
        
        if let image = profile.imageProfile  {
            self.profileImageView.image = UIImage(data: image)
        }
        
        self.nameTextField.text = profile.nameProfile
        self.passwordTextField.text = profile.passwordProfile
    }
    
    func profile(profileUpdated profile: ProfileEntity) {
        
    }
    
}
