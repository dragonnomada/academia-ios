//
//  RegisterUserViewController.swift
//  ProfileModule
//
//  Created by MacBook on 27/01/23.
//

import UIKit

class RegisterUserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    weak var presenter: RegisterUserPresenter?
    
    
    @IBAction func selectImageActionbutton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Selecciona una imagen", message: "Desde donde", preferredStyle: .alert)
        
        let galeria = UIAlertAction(title: "Galeria", style: .default) {
            
            _ in self.mostrarImagenSeleccionada(imagenSeleccionada: .photoLibrary)
            
        }
        
        alert.addAction(galeria)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func mostrarImagenSeleccionada(imagenSeleccionada: UIImagePickerController.SourceType) {
        
        guard UIImagePickerController.isSourceTypeAvailable(imagenSeleccionada) else {
            
            print("Error, imagen no validad")
            return
            
        }
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = imagenSeleccionada
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let imagenSeleccionada = info[.originalImage] as? UIImage {
            self.imageUser.image = imagenSeleccionada
        } else {
            print("Imagen no encontrada")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var imageUser: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageUser.layer.cornerRadius = imageUser.bounds.size.width / 2
        
        
    }

    @IBAction func signInActionButton(_ sender: Any) {
        
        if let name = nameTextField.text,
           let email = emailTextField.text,
           let password = passwordTextField.text {
            
            if name == "" {
                
                let alert = UIAlertController(title: "Register Failed", message: "Please insert a valid name", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true)
                
                return
                
            }
            
            if email == "" {
                
                let alert = UIAlertController(title: "Register Failed", message: "Please insert a valid email", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true)
                
                
                return
                
            }
            
            if password == "" {
                
                let alert = UIAlertController(title: "Register Failed", message: "Please insert a valid password", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true)
                
                
                return
                
            }

            self.presenter?.registerUser(name: name, email: email, password: password, image: imageUser.image?.pngData())
            
        }
        
        else {
            
            let alert = UIAlertController(title: "Register Failed", message: "User Register Failed", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alert, animated: true)
            
        }
        
    }
    
    @IBAction func cancelActionButton(_ sender: Any) {
        
        self.presenter?.closeRegister()
        
    }
    
    
}

extension RegisterUserViewController: RegisterUserDelegate {
    
    func userRegister(userRegistered userAuthCreate: UserAuthInfoEntity) {
        
        print("Exito al registrar")
        
        let alert = UIAlertController(title: "User Registered Succesfully", message: "the user has been Registered succesfully", preferredStyle: .alert)
                
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in self.presenter?.closeRegister() } ))

        self.present(alert, animated: true)
        
    }
    
}
