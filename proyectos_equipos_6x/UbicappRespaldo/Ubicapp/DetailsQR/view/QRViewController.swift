//
//   Proyecto: Ubicapp
//
// Autores:
// Joel Brayan Navor Jimenez
// Jonathan
// Heber Eduardo Jimenez Rodriguez
//
// Creado el 12 de enero del 2023 por jonothan Amador
// Modificaciones:
// Modificado por: Jonathan Amador el 13/01/2023
//
//

import UIKit

class QRViewController: UIViewController {
    // IBOutlets
    @IBOutlet weak var ubicacionImageView: UIImageView!
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var latitudLabel: UILabel!
    @IBOutlet weak var longitudLabel: UILabel!
    @IBOutlet weak var qrImageView: UIImageView!
    
    // generamos una variable de tipo Protocolo obpcional
    var ubicacionSelecionada: UbicacionEntity?
    // generamos un objeto del modelo
    var qrViewModel: QRViewModel?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Cuándo aparece esta vista solicita la última ubicación seleccionada
        self.qrViewModel?.requestUbicacionSeleccionada()
        
    }

    @IBAction func agregarImagenTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecct one imagen", message: "Where do you want to choose a Image", preferredStyle: .alert)
        // se creo la accion de la camara
        let camaraAction = UIAlertAction(title: "Camara", style: .destructive) {_ in
            self.mostarImagePicker(sourceType: .camera)
        }
        // recordemos agregar la accion
        alert.addAction(camaraAction)
        // se creo la accion de la accion de la biblioteca
        let bibliotecaButon = UIAlertAction(title: "Biblioteca", style: .default) {_ in
            self.mostarImagePicker(sourceType: .photoLibrary)
        }
        alert.addAction(bibliotecaButon)
        // se creo la accion de cancelar
        let cancelButon = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
       
        // recordemos agregar la accion
        alert.addAction(cancelButon)
        
        // recordemos que el present va a mostrar la alert
        present(alert, animated: true)
        
    }
    
    @IBAction func compartirTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let image = ubicacionImageView.image?.pngData() else {return}
        guard let name = nombreTextField.text else {return}
        self.qrViewModel?.actualizarUbicacion(name: name, image: image)
    }
    
    func mostarImagePicker(sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            print("data source no disponible")
            return
        }
        
        // realizamos un objeto de UIImagePickerController
        let imagePickerController = UIImagePickerController()
        
        // configuarar el image picker
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        imagePickerController.allowsEditing = false
        
        self.present(imagePickerController, animated: true)
    }
    
    
}

extension QRViewController: QRView {
    
    // La vista recibe la última ubicación seleccionada
    // ya sea la que pidió al aparecer o la que viene
    // automáticamente de la suscripción
    func ubicacion(ubicacionSelecionada: UbicacionEntity?) {
        self.ubicacionSelecionada = ubicacionSelecionada
        
        // Si hay una ubicación seleccionada refrescamos la vista
        // es decir, actualizamos los controles (labels y demás)
        if let ubicacionSelecionada = ubicacionSelecionada {
            // set la imagen del ubicacion
            if let imagenData = ubicacionSelecionada.imagen {
                let ubicacionImagen = UIImage(data: imagenData)
                ubicacionImageView.image = ubicacionImagen
                
            }
            // set el nombre la ubicacion
            nombreTextField.text = ubicacionSelecionada.nombre
            // set el lat la ubicacion
            latitudLabel.text = String(format: "%.2f", ubicacionSelecionada.latitud)
            // set el lon la ubicacion
            longitudLabel.text = String(format: "%.2f", ubicacionSelecionada.longitud)
            // set la imagen del qr
            let qrImage = generarCodigoQR(from: "\(ubicacionSelecionada.latitud), \(ubicacionSelecionada.longitud)")
            qrImageView.image = qrImage
        }
    }
    
    func ubicacion(ubicacionActualizada ubicacion: UbicacionEntity?) {
        //self.ubicacionSelecionada.actualizarUbicacion(
    }
}

extension QRViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Este metodo se ejecuta cuando el usurio seleciona una image, o toma una foto
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            ubicacionImageView.image = image
        } else {
            print("imagen no encontrada")
        }
        picker.dismiss(animated: true)
    }
}
