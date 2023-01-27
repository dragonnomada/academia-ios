//: [Previous](@previous)

//
// 102 - Usar el Centro de Notificaciones
//
// Por Alan Badillo Salas (alan@nomadacode.com)
//
// Creado el 25 de enero de 2023
//

import Foundation
import UIKit
import PlaygroundSupport

/// Un servicio es aquél responsable de mantener un estado y notificar
/// cuándo ocurren eventos o cambios dentro del estado.
///
/// El servicio `ContadorService` es responsable de incrementar
/// y decrementar un conteo
class ContadorService: NSObject {
    
    /// El `NotificationCenter` es un transmisor de eventos
    /// global que permite publicar y observar objetos
    /// entre distintas clases
    let notificationCenter = NotificationCenter.default
    
    /// Retenemos el estado del conteo
    var conteo: Int = 0
    
    /// Incrementamos el conteo y publicamos una notificación,
    /// es decir, transmitimos un evento
    func incrementar() {
        
        self.conteo += 1
        
        print("Incrementando: \(self.conteo)")
        
        // La notificación requiere un nombre
        // dónde los observadores de ese nombre
        // recibirán los objetos transmitidos
        self.notificationCenter.post(name: NSNotification.Name(rawValue: "contador.incrementar"), object: self.conteo)
        
    }
    
    /// Decrementamos el conteo y publicamos una notificación,
    /// es decir, transmitimos un evento
    func decrementar() {
        
        self.conteo -= 1
        
        print("Decrementando: \(self.conteo)")
        
        // La notificación requiere un nombre
        // dónde los observadores de ese nombre
        // recibirán los objetos transmitidos
        self.notificationCenter.post(name: NSNotification.Name(rawValue: "contador.decrementar"), object: self.conteo)
        
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
    
    /// Para escuchar las notificaciones usamos
    /// el `NotificationCenter` para observar los eventos
    /// transmitidos bajo el nombre que se publicaron
    let notificationCenter = NotificationCenter.default
    
    /// Definimos el `UILabel` que mostrará el valor del contador
    var conteoLabel: UILabel!
    /// Definimos el `UIButton` que permitirá incrementar el contador
    var incrementarButton: UIButton!
    /// Definimos el `UIButton` que permitirá decrementar el contador
    var decrementarButton: UIButton!
    
    /// Al cargar la Vista generamos los controles y suscribimos los
    /// eventos del centro de notificaciones
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
        
        // Observamos los objetos publicados en el
        // centro de notificaciones mediante el nombre
        // de evento `contador.incrementar`
        self.notificationCenter.addObserver(self, selector: #selector(self.incrementarObserver), name: NSNotification.Name(rawValue: "contador.incrementar"), object: nil)
        
        // Observamos los objetos publicados en el
        // centro de notificaciones mediante el nombre
        // de evento `contador.decrementar`
        self.notificationCenter.addObserver(self, selector: #selector(self.decrementarObserver), name: NSNotification.Name(rawValue: "contador.decrementar"), object: nil)
        
    }
    
    /// Al destruirse esta vista debemos dejar de observar lo que ocurre
    /// en el centro de notificacioens
    deinit {
        
        // Dejamos de observar el centro de notificaciones
        // para el nombre de evento `contador.incrementar`
        self.notificationCenter.removeObserver(self, name: NSNotification.Name(rawValue: "contador.incrementar"), object: nil)
        
        // Dejamos de observar el centro de notificaciones
        // para el nombre de evento `contador.decrementar`
        self.notificationCenter.removeObserver(self, name: NSNotification.Name(rawValue: "contador.decrementar"), object: nil)
        
    }
    
    /// Este método es usado por el observador para llamarse cada
    /// que la notificación `contador.incrementar` sea publicada
    @objc func incrementarObserver(notification: Notification) {
        
        print("Notificación de contador.incrementar")
        
        // Recuperamos el objeto publicado
        // en la notificación para actualizar el `UILabel`
        if let conteo = notification.object as? Int {
            
            DispatchQueue.main.async {
                
                self.conteoLabel.text = "\(conteo)"
                
            }
            
        }
        
    }
    
    /// Este método es usado por el observador para llamarse cada
    /// que la notificación `contador.decrementar` sea publicada
    @objc func decrementarObserver(notification: Notification) {
        
        print("Notificación de contador.decrementar")
        
        // Recuperamos el objeto publicado
        // en la notificación para actualizar el `UILabel`
        if let conteo = notification.object as? Int {
            
            DispatchQueue.main.async {
                
                self.conteoLabel.text = "\(conteo)"
                
            }
            
        }
        
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

let thread = Thread(block: {
    
    while true {
        
        print("Esperando 5 segundos")
        
        Thread.sleep(forTimeInterval: 5)
        
        AppManager.contadorService.incrementar()
        
    }
    
})

thread.start()

// Ajustamos el Playground para que muestre la Vista
PlaygroundPage.current.liveView = contadorViewController
PlaygroundPage.current.needsIndefiniteExecution = true

//: [Next](@next)
