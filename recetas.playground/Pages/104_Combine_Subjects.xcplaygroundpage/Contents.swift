//: [Previous](@previous)

//
// 104 - Usar de Sujetos de Combine
//
// Por Alan Badillo Salas (alan@nomadacode.com)
//
// Creado el 25 de enero de 2023
//

import Foundation
import Combine
import UIKit
import PlaygroundSupport

/// Un servicio es aquél responsable de mantener un estado y notificar
/// cuándo ocurren eventos o cambios dentro del estado.
///
/// El servicio `ContadorService` es responsable de incrementar
/// y decrementar un conteo
class ContadorService {
    
    /// Retenemos el estado del conteo
    var conteo: Int = 0
    
    /// Los sujetos permiten emitir objetos de un tipo dado
    /// y un error de completado personalizado (generalmente Never).
    /// Usamos este sujeto para transmitir el valor del conteo
    /// cada que este se incrementa.
    let incrementadoSubject = PassthroughSubject<Int, Never>()
    
    /// Los sujetos permiten emitir objetos de un tipo dado
    /// y un error de completado personalizado (generalmente Never).
    /// Usamos este sujeto para transmitir el valor del conteo
    /// cada que este se decrementa.
    let decrementadoSubject = PassthroughSubject<Int, Never>()
    
    /// Incrementa la propiedad conteo
    func incrementar() {
        
        self.conteo += 1
        
        // Notificamos el conteo a los suscriptores
        // del sujeto que informa que se ha incrementado
        self.incrementadoSubject.send(self.conteo)
        
    }
    
    /// Decrementa la propiedad conteo
    func decrementar() {
        
        self.conteo -= 1
        
        // Notificamos el conteo a los suscriptores
        // del sujeto que informa que se ha decrementado
        self.decrementadoSubject.send(self.conteo)
        
    }
    
}

/// Administramos una instancia del servicio
///
/// Esta instancia debería ser absorbida por algún interactor en VIPER
class AppManager {
    
    /// Una instancia estática del servicio del contador
    static let contadorService = ContadorService()
    
}

/// Definimos una Vista para mostrar el contador e interactuar con él
class ContadorViewController: UIViewController {
    
    /// Creamos un suscriptor para el sujeto del servicio
    /// que notifica cada que el contado se ha incrementado
    var incrementadoSubscriber: AnyCancellable?
    /// Creamos un suscriptor para el sujeto del servicio
    /// que notifica cada que el contado se ha decrementado
    var decrementadoSubscriber: AnyCancellable?
    
    /// Definimos el `UILabel` que mostrará el valor del contador
    var conteoLabel: UILabel!
    /// Definimos el `UIButton` que permitirá incrementar el contador
    var incrementarButton: UIButton!
    /// Definimos el `UIButton` que permitirá decrementar el contador
    var decrementarButton: UIButton!
    
    /// Al cargar la Vista generamos los controles y suscribimos el
    /// publicador que reportará el valor modificado
    override func viewDidLoad() {
        
        // Definimos la vista principal
        let view = UIView()
        
        // Construimos el `UILabel`
        self.conteoLabel = UILabel(frame: CGRect(x: 40, y: 40, width: 100, height: 20))
        
        self.conteoLabel.text = "0"
        
        // Construimos el `UIButton` para incrementar
        self.incrementarButton = UIButton(frame: CGRect(x: 40, y: 80, width: 100, height: 20))
        
        // Ajustamos el `UIButton` para incrementar
        self.incrementarButton.setTitle("Incrementar", for: .normal)
        self.incrementarButton.setTitleColor(.systemBlue, for: .normal)
        
        // Conectamos el evento `.touchUpInside`
        // del botón haciá un método `@objc`
        self.incrementarButton.addTarget(self, action: #selector(self.incrementarAction), for: .touchUpInside)
        
        // Construimos el `UIButton` para decrementar
        self.decrementarButton = UIButton(frame: CGRect(x: 40, y: 120, width: 100, height: 20))
        
        // Ajustamos el `UIButton` para decrementar
        self.decrementarButton.setTitle("Decrementar", for: .normal)
        self.decrementarButton.setTitleColor(.systemPink, for: .normal)
        
        // Conectamos el evento `.touchUpInside`
        // del botón haciá un método `@objc`
        self.decrementarButton.addTarget(self, action: #selector(self.decrementarAction), for: .touchUpInside)
        
        // Agregamos los controles al `UIView` principal
        view.addSubview(self.conteoLabel)
        view.addSubview(self.incrementarButton)
        view.addSubview(self.decrementarButton)
        
        // Definimos que el `UIView` es el principal
        self.view = view
        
        // Suscribimos el sujeto que notifica que el
        // contado ha incrementado
        self.incrementadoSubscriber = AppManager.contadorService.incrementadoSubject.sink(receiveValue: {
            
            // Las clausuras atrapan automáticamente
            // a `self` por lo que debemos cuidar
            // que no se cree un ciclo de referencias
            // mediante `[weak self]`.
            // La clausura recibe el valor publicado.
            [weak self] conteo in
            
            // Debemos cuidar no actualizar la vista
            // sobre otro hilo que no sea el principal
            DispatchQueue.main.async {
                
                // Actualiza el `UILabel` en el hilo
                // principal
                self?.conteoLabel.text = "\(conteo) INC"
                
            }
            
        })
        
        // Suscribimos el sujeto que notifica que el
        // contado ha decrementado
        self.decrementadoSubscriber = AppManager.contadorService.decrementadoSubject.sink(receiveValue: {
            
            // Las clausuras atrapan automáticamente
            // a `self` por lo que debemos cuidar
            // que no se cree un ciclo de referencias
            // mediante `[weak self]`.
            // La clausura recibe el valor publicado.
            [weak self] conteo in
            
            // Debemos cuidar no actualizar la vista
            // sobre otro hilo que no sea el principal
            DispatchQueue.main.async {
                
                // Actualiza el `UILabel` en el hilo
                // principal
                self?.conteoLabel.text = "\(conteo) DEC"
                
            }
            
        })
        
    }
    
    /// Al destruirse esta vista debemos dejar de observar las publicaciones
    /// a las que nos suscribimos
    deinit {
        
        // Cancelamos la suscripción
        self.incrementadoSubscriber?.cancel()
        // Liberamos la propiedad
        self.incrementadoSubscriber = nil
        
        // Cancelamos la suscripción
        self.decrementadoSubscriber?.cancel()
        // Liberamos la propiedad
        self.decrementadoSubscriber = nil
        
    }
    
    /// Definimos el método para controlar el `.touchUpInside`
    /// del `UIButton` para incrementar
    @objc func incrementarAction() {
        
        // Mandamos una operación al servicio
        // esto tendría que pasar por un `Presenter`
        // y luego por un `Interactor` para llegar
        // al `Service` finalmente.
        // Pero por simplicidad usamos el
        // singletón para incrementar directamente
        // el contador a través del servicio
        AppManager.contadorService.incrementar()
        
    }
    
    /// Definimos el método para controlar el `.touchUpInside`
    /// del `UIButton` para decrementar
    @objc func decrementarAction() {
        
        // Mandamos una operación al servicio
        // esto tendría que pasar por un `Presenter`
        // y luego por un `Interactor` para llegar
        // al `Service` finalmente.
        // Pero por simplicidad usamos el
        // singletón para decrementar directamente
        // el contador a través del servicio
        AppManager.contadorService.decrementar()
        
    }
    
}

// Creamos una prueba unitaria de la Vista

// Definimos una instancia manual de la Vista
let contadorViewController = ContadorViewController()

// Ajustamos el Playground para que muestre la Vista
PlaygroundPage.current.liveView = contadorViewController
PlaygroundPage.current.needsIndefiniteExecution = true

//: [Next](@next)
