//
// Proyecto: Ubicapp
//
// Autores:
// Joel Brayan Navor Jimenez
// Jonathan
// Heber Eduardo Jimenez Rodriguez
//
// Creado el 12 de enero del 2023
//

import UIKit
import MapKit

class MapaViewController: UIViewController {
    
    // Pasamos modelo vista
    weak var mapaViewModel: MapaViewModel?
    
    // Mapa
    @IBOutlet weak var myMapKit: MKMapView!
    
    // Vista que muestra los detalles de cada ubicaion, cuando se selecciona
    @IBOutlet weak var detallesUbicacionView: UIView!
    
    // Label que muestra la laitud de cada ubicacion seleccionada
    @IBOutlet weak var latitudLabel: UILabel!
    
    // Label que muestra la longitud de cada ubicacion seleccionada
    @IBOutlet weak var longitudLabel: UILabel!
    
    // Label que muestra el nombre de cada ubicacion seleccionada
    @IBOutlet weak var nombreUbicacionLabel: UILabel!
    
    // Label del constrain para poder hacer el efecto de aparecer y desaparecer la pantalla de detalles de una ubicacion seleccionada
    @IBOutlet weak var centerPupUpConstrain: NSLayoutConstraint!
    
    // Variable para poder aparecer y desaparecer la pantalla de detalles de la ubicacion
    var pantallaPupOp: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuracoin del color de la vista
        view.backgroundColor = .link
        
        // Configuracion del color de la pantalla de detalles de laubicacion seleccionada
        detallesUbicacionView.backgroundColor = .opaqueSeparator
        
        // Configuracion para que la pantalla detalles de laubicacion aparezca con las esquinas redondeadas
        detallesUbicacionView.layer.cornerRadius = 20
        detallesUbicacionView.layer.masksToBounds = true
        
        // Configuracion para que la pantalla detalles de la ubicacion desaparezca al iniciar la app
        centerPupUpConstrain.constant = -700
        
        mapaViewModel?.view = self
        
        // Ubicacion por defecto
        let ubicacionDefault = CLLocation(latitude: 21.127052, longitude: -101.688952)
        self.myMapKit.centerToLocation(ubicacionDefault)
        
        // El delgado sera esta vista
        self.myMapKit.delegate = self
        
        // Se manda a llamar a la funcion que configura el gesto que se ocupa para la creacion de una nueva ubicacion
        self.configuracionDelGesto()
        
        // Configuracion por defecto, del punto en el que nos encontramos al abrir la pantalla
        let mark = MKPointAnnotation()
        mark.title = "Hola"
        mark.coordinate = CLLocationCoordinate2D(latitude: 21.127052, longitude: -101.688952)
        self.myMapKit.addAnnotation(mark)
    }

    override func viewDidAppear(_ animated: Bool) {
        
        // Actualiza las ubicaciones
        self.mapaViewModel?.refreshUbicaciones()
    }
    
    // Configuracion del gesto que genera una ubicacion nueva
    func configuracionDelGesto() {
        let gestureLongPress = UILongPressGestureRecognizer(target: self, action:#selector(self.handleLongPress))
        gestureLongPress.minimumPressDuration = 1
        gestureLongPress.delaysTouchesBegan = true
        gestureLongPress.delegate = self
        self.myMapKit.addGestureRecognizer(gestureLongPress)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        
        // Para no hacer doble generacion de punto
        if gestureRecognizer.state == UIGestureRecognizer.State.ended {
                    return
        }
        
        else if gestureRecognizer.state == UIGestureRecognizer.State.began {
            
            let touchPoint = gestureRecognizer.location(in: self.myMapKit)
            
            let touchMapCoordinate =  self.myMapKit.convert(touchPoint, toCoordinateFrom: self.myMapKit)
            
            print("Generando puntooooo")
            
            // Agregar la nueva ubicacion generada, en nuestro mapa
            self.mapaViewModel?.agregarUbicacion(latitud: Double(touchMapCoordinate.latitude), longitud: Double(touchMapCoordinate.longitude))
        }
    }
    
    // Boton para ver los detalles de cada ubicacion seleccionada
    @IBAction func detallesUbicacionButton(_ sender: Any) {
        
        // Pasar a vista de detalles de la ubicacion seleccionada
        self.navigationController?.pushViewController(QRViewController(), animated: false)
    }
    
    @IBAction func aceptarButton(_ sender: Any) {
        
        // Desaparece de nuevo la pantalla detalles de la ubicacion
        centerPupUpConstrain.constant = -700
        // Regresa la transaprecncia del mapa a su valor normal
        self.myMapKit.alpha = 1
    }
    
}

extension MapaViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        return false
    }
}

class MapaAnnotation: MKPointAnnotation {
    
    var ubicacion: UbicacionEntity?
    
}

extension MapaViewController: MapaView {
    
    func ubicacion(ubicaciones: [UbicacionEntity]) {
        
        ubicaciones.forEach { [weak self] ubicacion in
            
            let mark = MapaAnnotation()
            
            mark.title = ubicacion.nombre
            mark.ubicacion = ubicacion
            
            let latitud = ubicacion.latitud
            let longitud = ubicacion.longitud
            
            print("Ubicacion: (\(ubicacion.latitud.redondear(numeroDeDecimales: 4)), \(ubicacion.longitud.redondear(numeroDeDecimales: 4))")
            
            mark.coordinate = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
 
            self?.myMapKit.addAnnotation(mark)
        }
        
        myMapKit.reloadInputViews()
    }
    
    func ubicacion(ubicacionSeleccionada ubicacion: UbicacionEntity) {
        
        //self.latitudLabel.text = "Lat: \(Double(Int(ubicacion.latitud * 10_000)) / 10_000)"
        //self.longitudLabel.text = "Long: \(Double(Int(ubicacion.longitud * 10_000)) / 10_000)"
        self.latitudLabel.text = "Lat: \(ubicacion.latitud.redondear(numeroDeDecimales: 4))"
        self.longitudLabel.text = "Long: \(ubicacion.longitud.redondear(numeroDeDecimales: 4))"
        self.nombreUbicacionLabel.text = ubicacion.nombre
        
        pantallaPupOp = !pantallaPupOp
        
        if pantallaPupOp {
            
            centerPupUpConstrain.constant = 0
            
            UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseOut) {
                self.detallesUbicacionView.layoutIfNeeded()
                self.myMapKit.alpha = 0.5
            }
        } else {
            centerPupUpConstrain.constant = -700
        }
    }
}

// Limita el numero de decimales mostrados
extension Double {
    func redondear(numeroDeDecimales: Int) -> String {
        let formateador = NumberFormatter()
        formateador.maximumFractionDigits = numeroDeDecimales
        formateador.roundingMode = .down
        return formateador.string(from: NSNumber(value: self)) ?? ""
    }
}

extension MapaViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        
        if let mapaUbicacion = annotation as? MapaAnnotation {
            
            if let ubicacion = mapaUbicacion.ubicacion {
                self.mapaViewModel?.seleccionarUbicacion(id: Int(ubicacion.id))
            }
        }
    }
}

private extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
