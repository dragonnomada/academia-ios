//
//  ViewController.swift
//  MapKitConUbicaciones
//
//  Created by MacBook on 13/01/23.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    
    var latitud: CLLocationDegrees?
    var longitud: CLLocationDegrees?

    @IBOutlet weak var myMap: MKMapView!
    
    // Manager para hacer uso del gps *Investigar documentacion
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegado del manager
        manager.delegate = self
        // Permiso del usuario
        manager.requestWhenInUseAuthorization()
        // Solicitar ubicacion
        manager.requestLocation()
        // Precision de la ubicacion
        manager.desiredAccuracy = kCLLocationAccuracyBest
        // Monitorea la ubicaicon en todo momento
        manager.startUpdatingLocation()
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    // Cuando se obtiene una ubicacion
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Numero de ubicaciones \(locations.count)")
        
        // Asegura que exista una ubicacion
        guard let ubicacion = locations.last else {
            return
        }
        
        latitud = ubicacion.coordinate.latitude
        longitud = ubicacion.coordinate.longitude
        print(ubicacion)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error al obtener ubicacion \(error.localizedDescription)")
    }
    
}

