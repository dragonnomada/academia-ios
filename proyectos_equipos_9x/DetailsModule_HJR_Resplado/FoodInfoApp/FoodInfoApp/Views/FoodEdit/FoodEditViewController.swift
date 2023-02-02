//
//  FoodEditViewController.swift
//  FoodInfoApp
//
//  Created by MacBook on 27/01/23.
//

import UIKit

class FoodEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageFood: UIImageView!
    
    weak var presenter: FoodEditPresenter?
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var calTextField: UITextField!
    
    @IBOutlet weak var fatTextField: UITextField!
    
    @IBOutlet weak var sugarTextField: UITextField!
    
    @IBOutlet weak var fiberTextField: UITextField!
    
    @IBOutlet weak var carbsTextField: UITextField!
    
    @IBOutlet weak var proteinTextField: UITextField!
    
    @IBOutlet weak var unitTextField: UITextField!
    
    @IBOutlet weak var imageFoodEdit: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let sheet = presentationController as? UISheetPresentationController else { return }
        
        sheet.detents = [.medium(), .large()]
        sheet.selectedDetentIdentifier = .medium
        sheet.prefersGrabberVisible = true
        sheet.preferredCornerRadius = 20
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter?.requestFoodSelected()
    }
    
    
    @IBAction func selectImageFood(_ sender: Any) {
        
        let alert = UIAlertController(title: "Selecciona una imagen", message: "Desde donde", preferredStyle: .alert)
        
        let galeria = UIAlertAction(title: "Galeria", style: .default) { _ in self.mostrarImagenSeleccionada(imagenseleccionada: .photoLibrary)
            
        }
        
        alert.addAction(galeria)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func mostrarImagenSeleccionada(imagenseleccionada: UIImagePickerController.SourceType) {
        
        guard UIImagePickerController.isSourceTypeAvailable(imagenseleccionada) else {
            
            print("Error, imagen no valida")
            return
        }
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = imagenseleccionada
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imagenSeleccionada = info[.originalImage] as? UIImage {
            
            self.imageFood.image = imagenSeleccionada
            
        } else {
            
            print("Imagen no encontrada")
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        // Se corrobora que los textfield no esten vacios
        guard let name = nameTextField.text else {
            return
        }
        
        guard let cal = calTextField.text else {
            return
        }
        
        guard let fat = fatTextField.text else {
            return
        }
        
        guard let sugar = sugarTextField.text else {
            return
        }
        
        guard let fiber = fiberTextField.text else {
            return
        }
        
        guard let carbs = carbsTextField.text else {
            return
        }
        
        guard let protein = proteinTextField.text else {
            return
        }
        
        guard let units = unitTextField.text else {
            return
        }
        
        // Se convierten todos los valores introducidos en textField en Double
        guard let calnum = Double(cal) else {
            return
        }
        
        guard let fatnum = Double(fat) else {
            return
        }
        
        guard let sugarnum = Double(sugar) else {
            return
        }
        
        guard let fibernum = Double(fiber) else {
            return
        }
        
        guard let carbsnum = Double(carbs) else {
            return
        }
        
        guard let proteinnum = Double(protein) else {
            return
        }
        
        guard let unitsnum = Double(units) else {
            return
        }
        
        self.presenter?.updateFood(name: name, calories: calnum, carbs: carbsnum, fat: fatnum, fiber: fibernum, protein: proteinnum, sugar: sugarnum, units: unitsnum, image: imageFood.image?.pngData())
    }
    
}

extension FoodEditViewController: FoodEditDelegate {
    
    func food(foodEdited food: FoodEntity) {
        print("l")
        
        nameTextField.text = food.name
        calTextField.text = food.calories.description
        fatTextField.text = food.fat.description
        sugarTextField.text = food.sugar.description
        fiberTextField.text = food.fiber.description
        carbsTextField.text = food.carbs.description
        proteinTextField.text = food.protein.description
        unitTextField.text = food.units.description
    }
    
}
