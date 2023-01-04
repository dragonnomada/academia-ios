//
//  ViewController.swift
//  imagePickerDemo
//
//  Created by MacBook Pro on 27/12/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    
    
    @IBOutlet weak var urlTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addImagePress(_ sender: Any) {
        let alert = UIAlertController(title: "Selcciona una imagen", message: "¿Desde donde quieres seleccionar imagen?", preferredStyle: .actionSheet)
        
        let camaraBoton = UIAlertAction(title: "Camara", style: .default) { _ in
            self.mostrarImagenSeleccionada(imagenSeleccionada: .camera)
        }
        
        let libreriaBoton = UIAlertAction(title: "Libreria", style: .default) { _ in
            self.mostrarImagenSeleccionada(imagenSeleccionada: .photoLibrary)
        }
        
        let cancelBotton = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(camaraBoton)
        alert.addAction(libreriaBoton)
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
            
            var qrCodeLink = ""
            let detector: CIDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])!
            let ciImage: CIImage = CIImage(image:imagenSeleccionada)!
            let features=detector.features(in: ciImage)
            
            for feature in features as! [CIQRCodeFeature] {
                qrCodeLink += feature.messageString!
            }
            
            if qrCodeLink == "" {
                urlTextField.text = "Error imagen QR"
            }else{
                urlTextField.text = qrCodeLink
            }

            imageView.image = imagenSeleccionada
        } else {
            print("Imagen no encontrada")
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

