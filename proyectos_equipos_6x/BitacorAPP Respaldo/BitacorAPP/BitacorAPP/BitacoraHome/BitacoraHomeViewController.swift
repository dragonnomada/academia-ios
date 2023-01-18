//
//  BitacoraHomeViewController.swift
//  BitacorAPP
//
//  Created by MacBook Pro on 12/01/23.
//

import UIKit
import MapKit

class BitacoraHomeViewController: UIViewController {
    
    
    weak var viewModel: BitacoraHomeViewModel?
    
    // Bitacora Outlet para animación
    @IBOutlet weak var bitacotaView: UIView!
    
    // TODO: Documentación de Outels de la Bitacora
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var latlonLabel: UILabel!
    
    // TODO: Documentanción definicion IBOULETS MAP
    @IBOutlet weak var homeMapView: MKMapView!
    
    var autoloadBitacotas: Bool = true
    var isHidden: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Default Location
        let initialLocation = CLLocation(latitude: 19.397956, longitude: -99.17199)
        homeMapView.centerToLocation(initialLocation)
        
        
        
        // Default View Pop
        setupView()
        
        self.homeMapView.delegate = self
        
        self.setupGestureLongPressToMap()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        // TODO: Refresh bitácoras
        
        if autoloadBitacotas {
            print("RECARGA TODO")
            self.viewModel?.refreshBitacoras()
            self.autoloadBitacotas = false
            
            self.isHidden = true
            UIView.animate(withDuration: 0.8, delay: 0) {
                self.bitacotaView.transform = self.bitacotaView.transform.translatedBy(x: 0, y: 300)
            }
        }
        
    }
    
    
    @IBAction func goDetailsAction(_ sender: Any?) {
        
        self.navigationController?.pushViewController(BitacoraDetailsViewController(), animated: true)
    }
    
    func setupGestureLongPressToMap() {
        let gestureLongPress = UILongPressGestureRecognizer(target: self, action:#selector(self.handleLongPress))
        gestureLongPress.minimumPressDuration = 1
        gestureLongPress.delaysTouchesBegan = true
        gestureLongPress.delegate = self
        self.homeMapView.addGestureRecognizer(gestureLongPress)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizer.State.ended {
                    return
        }
        
        else if gestureRecognizer.state == UIGestureRecognizer.State.began {
            
            let touchPoint = gestureRecognizer.location(in: self.homeMapView)
            
            let touchMapCoordinate =  self.homeMapView.convert(touchPoint, toCoordinateFrom: self.homeMapView)
            
            print(touchMapCoordinate)
    
            self.viewModel?.addBitacora(latitude: Decimal(touchMapCoordinate.latitude), longitude: Decimal(touchMapCoordinate.longitude))
            
        }
    }

    func setupView() {
        self.homeMapView.layer.cornerRadius = bitacotaView.bounds.size.width / 30
//        let originalTransform = self.bitacotaView.transform
//            let scaledTransform = originalTransform.scaledBy(x: 0.2, y: 0.2)
//            let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 250.0)
//            UIView.animate(withDuration: 0.7, animations: {
//                self.v.transform = scaledAndTranslatedTransform
//            })
    }
    
}

extension BitacoraHomeViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        return false
    }
    
}

// TODO: Documentacion Extension de la Bitacora

class BitacoraAnnotation: MKPointAnnotation {
    
    var bitacora: BitacoraEntity?
    
}

extension BitacoraHomeViewController: BitacoraHomeView {
    
    func bitacora(bitacoras: [BitacoraEntity]) {
        
        self.homeMapView.removeAnnotations(self.homeMapView.annotations)
        
        bitacoras.forEach {
            [weak self] bitacora in
            
            let mark = BitacoraAnnotation()
    
            mark.title = bitacora.title
            mark.bitacora = bitacora
            
            guard let latitud = bitacora.latitude else { return }
            guard let longitud = bitacora.longitude else { return }

            mark.coordinate = CLLocationCoordinate2D(latitude: latitud.doubleValue, longitude: longitud.doubleValue)
 
            self?.homeMapView.addAnnotation(mark)
            
        }
        
        homeMapView.reloadInputViews()
                
    }
    
    func bitacora(bitacoraSelected: BitacoraEntity) {
        
        if isHidden {
            self.isHidden = false
            
            UIView.animate(withDuration: 0.8, delay: 0) {
                self.bitacotaView.transform = self.bitacotaView.transform.translatedBy(x: 0, y: -300)
            }
        }
        
        self.titleLabel.text = bitacoraSelected.title
        
        let latitud = "\(bitacoraSelected.latitude ?? 0.0)".split(separator: ".")
        let longitug = "\(bitacoraSelected.longitude ?? 0.0)".split(separator: ".")
        
        self.latlonLabel.text = "#\(bitacoraSelected.id) (\(latitud[0]).\(latitud[0].first!), \(longitug[0]).\(latitud[0].first!))"
        
        homeMapView.reloadInputViews()
        
        guard let _ = bitacoraSelected.updateAt else {
            // La bitácora es nueva
            //self.goDetailsAction(nil)
            return
        }
    
    }
}


// MARK: extension MkMapViewDelegate

extension BitacoraHomeViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        
        if let bitacoraAnnotation = annotation as? BitacoraAnnotation {
            
            if let bitacora = bitacoraAnnotation.bitacora {
                self.viewModel?.selectBitacora(byId: Int(bitacora.id))
                //self.viewModel?.refreshBitacoras()
            }
            
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect annotation: MKAnnotation) {
        self.isHidden = true
        UIView.animate(withDuration: 0.8, delay: 0) {
            self.bitacotaView.transform = self.bitacotaView.transform.translatedBy(x: 0, y: 300)
        }
    }
    
}

// MARK: extension MKmapView
private extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 500) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

