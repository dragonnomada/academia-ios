//
//  AddViewController.swift
//  HomeModule
//
//  Created by User on 27/01/23.
//

import UIKit

class AddViewController: UIViewController, UINavigationControllerDelegate {

    weak var presenter: AddPresenter?
    
    @IBOutlet weak var foodImageView: UIImageView!
    
    @IBOutlet weak var foodNameTextField: UITextField!
    
    @IBOutlet weak var foodCaloriesTextField: UITextField!
    
    @IBOutlet weak var foodFatsTextField: UITextField!
    
    @IBOutlet weak var foodSugarsTextField: UITextField!
    
    @IBOutlet weak var foodFiberTextField: UITextField!
    
    @IBOutlet weak var foodCarbohydratesTextField: UITextField!
    
    @IBOutlet weak var foodProteinsTextField: UITextField!
    
    @IBOutlet weak var foodUnitTextField: UITextField!
    
    @IBOutlet weak var foodFactorTextField: UILabel!
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addAction(_ sender: Any) {
                        
        self.presenter?.createFood(
            name: self.foodNameTextField.text ?? "No name",
            calories: Double(self.foodCaloriesTextField.text ?? "0.0") ?? 0.0,
            fats: Double(self.foodFatsTextField.text ?? "0.0") ?? 0.0,
            sugars: Double(self.foodSugarsTextField.text ?? "0.0") ?? 0.0,
            fiber: Double(self.foodFiberTextField.text ?? "0.0") ?? 0.0,
            carbs: Double(self.foodCarbohydratesTextField.text ?? "0.0") ?? 0.0,
            proteins: Double(self.foodProteinsTextField.text ?? "0.0") ?? 0.0,
            unit: self.foodUnitTextField.text ?? "No units",
            factor: Double(self.foodFactorTextField.text ?? "0.0") ?? 0.0,
            image: foodImageView.image?.pngData())
        
        self.presenter?.closeAdd()
        
    }
    
    @IBAction func editFoodImageActionButton(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        
        self.presenter?.closeAdd()
    }
    
    
    
}

extension AddViewController: AddViewDelegate {
    
    func foods(foodCreated food: FoodEntity) {
        
        self.presenter?.closeAdd()
        
    }
    
}

extension AddViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            
            foodImageView.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true)
    }
}
