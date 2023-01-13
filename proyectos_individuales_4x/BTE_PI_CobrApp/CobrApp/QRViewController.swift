//
//  QRViewController.swift
//  CobrApp
//
//  Created by MacBook Pro on 28/12/22.
//

import UIKit
import AVFoundation

// Modelamos la respuesta de la api en el Producto
struct ProductoResponse: Codable {
    let error: Bool
    let message: String
    let product: Product?
    let confirm: String
}

struct Product: Codable {
    let id: Int
    let picture: String
    let description: String
    let amount: Double
    let brand: String
}

// Creamos una estructura producto que se cargar con la respuesta del API y se utilizará para enviar a la siguiente vista
struct Producto {
    let imagenURL: String
    let descripcionCargo: String
    let descripcionProducto: String
    let monto: Double
}

class QRViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Creamos usuario y Token variables que serán cargadas despues de generarlas
    // correctamente en la anterior vista
    
    var usuario: String?
    var token: String?
    
    // Creamos una vaiable producto que despues de ser cargada se enviará a la siguiente  vista
    var producto: Producto?
    
   

    @IBOutlet weak var qrImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Preparamos el prepare que mandara el producto para la siguiente vista
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "QR-Valido-Segue" {
            let destination = segue.destination as! CobroViewController
            destination.producto = self.producto
        }
    }
    
    // Creamos las alertas en la vista 1 controller para describir la alerta 3 action para accedeer a camara, photoLibrary y cancel
    
    @IBAction func agregarQRActionPress(_ sender: Any) {
        
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
            
            var qrCodeLink = ""
            
            let detector: CIDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])!
            let ciImage: CIImage = CIImage(image:imagenSeleccionada)!
            let features=detector.features(in: ciImage)
            
            for feature in features as! [CIQRCodeFeature] {
                qrCodeLink += feature.messageString!
            }
            
            if qrCodeLink == "" {
                performSegue(withIdentifier: "QR-Invalido-Segue", sender: nil)
                print("Error")
                
            } else {
                print(qrCodeLink)
                cargarArticuloQR(qrArticuloText: qrCodeLink, username: self.usuario!, token: self.token!)
                
            }
            
        } else {
            print("Imagen no encontrada")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func cargarArticuloQR(qrArticuloText: String, username: String, token: String) {
        
        print("Entro a cargarArticuloQR")
        print(qrArticuloText)
        print(username)
        print(token)
        
        let qrURL = "http://34.125.242.89/api/cobrapp/qr/send?code=\(qrArticuloText)&username=\(username)&token=\(token)"

        guard let url = URL(string: qrURL) else {
            print("no entro al url")
            return
        }

        let session = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print("Error de dataTask Cargar artigulo \(error)")
            }
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(ProductoResponse.self, from: data)
                    if response.error {
                        print(response.message)
                        let alert = UIAlertController(title: "Articulo Incorrectos", message: "Ingresa un QR de un articulo valido", preferredStyle: .alert)

                        let cancelBotton = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)

                        alert.addAction(cancelBotton)

                        self.present(alert, animated: true, completion: nil)

                    } else {
                        if let producto = response.product {
                            DispatchQueue.main.sync {
                                self.producto = Producto(imagenURL: producto.picture, descripcionCargo: producto.brand, descripcionProducto: producto.description, monto: producto.amount)
                                print(self.producto!)
                                self.performSegue(withIdentifier: "QR-Valido-Segue", sender: nil)
                            }
                        }
                    }
                    } catch {
                        print("JSON Cargar Articulo Error \(error)")
                    }
                }
            }
        session.resume()
        
        print("Salio de cargarArticuloQR")
        }
    
    
}
