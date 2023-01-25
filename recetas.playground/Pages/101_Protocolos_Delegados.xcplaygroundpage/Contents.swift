//: [Previous](@previous)

//
// 101 - Crear un Protocolo Delegado
//
// Por Alan Badillo Salas (alan@nomadacode.com)
//
// Creado el 25 de enero de 2023
//

import Foundation
import UIKit
import PlaygroundSupport

/// `ClockView` es un protocolo delegado que define métodos para que
/// una vista actualice los valores del reloj cuándo estos cambien
protocol ClockViewDelegate {
    
    /// Notifica a la vista que los segundos fueron actualizados
    func clock(updateSeconds seconds: Int)
    
    /// Notifica a la vista que los minutos fueron actualizados
    func clock(updateMinutes minutes: Int)
    
    /// Notifica a la vista que las horas fueron actualizadas
    func clock(updateHours hours: Int)
    
}

/// `ClockViewModel` representa un modelo vista que podrá hacer operaciones
/// independientes a la vista y notificar cuándo sea necesario los valores actualizados a la vista
class ClockViewModel {
    
    /// El delago es una instancia `tipo protocolo` que permite acceder a las
    /// funcionalidades descritas por el protocolo, según se hayan implementado en
    /// alguna clase o estructura que haya extendido este protocolo
    var delegate: ClockViewDelegate?
    
    /// Retiene los segundos actuales del reloj
    var seconds: Int = 0
    /// Retiene los minutos actuales del reloj
    var minutes: Int = 0
    /// Retiene las horas actuales del reloj
    var hours: Int = 0
    
    /// Determina si el reloj está pausado
    var isPaused: Bool = true
    /// Determina si el reloj está completado
    var isDone: Bool = false
    
    /// Define un hilo que ejecuta un bloque el cuál actualiza
    /// los segundos y si se cumplen las condiciones también los minutos y horas.
    ///
    /// Espera 1 segundo lógico para hacer la siguiente iteración y usa el delegado
    /// para notificar a la vista que algún valor ha sido actualizado.
    ///
    /// La variable es tipo `lazy` para poder acceder a `self` dentro de su construcción
    /// y escapamos la referencia de tipo `unowned` dentro de la clausura del hilo.
    lazy var thread: Thread = {
        
        // Crea un nuevo hilo para devolverlo tipo `lazy`
        let thread = Thread(block: {
            
            // La clausura no espera nada [() -> Void],
            // pero se marca un `unowned self`
            [unowned self] in
            
            print("Ejecutando hilo")
            
            // Repetimos mientras el reloj no esté completado
            while !self.isDone {
                
                print("Actualizando reloj")
                
                // Si el reloj no está pausado actualizamos
                if !self.isPaused {
                    
                    print("El reloj se actualizará: \(self.delegate != nil ? "CON DELEGADO" : "SIN DELEGADO")")
                    
                    self.seconds += 1
                    
                    // Separamos los cálculos de los minutos
                    if self.seconds == 60 {
                        
                        print("Incrementando minutos")
                        
                        self.seconds = 0
                        
                        self.minutes += 1
                        
                        // Separamos los cálculos de las horas
                        if self.minutes == 60 {
                            
                            print("Incrementando horas")
                            
                            self.minutes = 0
                            
                            self.hours += 1
                            
                            // Notificamos a la vista (delegado)
                            // que las horas fueron actualizadas
                            self.delegate?.clock(updateHours: hours)
                            
                        }
                        
                        // Notificamos a la vista (delegado)
                        // que los minutos fueron actualizados
                        self.delegate?.clock(updateMinutes: self.minutes)
                        
                    }
                    
                    // Notificamos a la vista (delegado)
                    // que los segundos fueron actualizados
                    self.delegate?.clock(updateSeconds: seconds)
                    
                    print("[\(self.hours)h \(self.minutes)m \(self.seconds)s]")
                    
                    // En este mismo bloque podrían darse 3
                    // notificaciones simultáneas a la vista
                    // Por lo que la vista debe estar preparada
                    // para recibir las notificaciones que
                    // provienen de este hilo (distinto al main)
                    // y actualizar la vista correctamente
                    
                }
                
                print("Esperando 1 segundo")
                
                // Podemos modificar el tiempo de actualización
                // prueba poner 0.1 para que el reloj vaya más rápido
                Thread.sleep(forTimeInterval: 1)
                
            }
            
        })
        
        // Devolvemos el hilo ya configurado
        return thread
        
    }()
    
    /// Equivalente a *continuar* el reloj
    func start() {
        
        // Si el hilo aún no está ejecutándose se manda a ejecutar
        // Esto lo hace sólo la primera vez
        if !self.thread.isExecuting {
            
            self.thread.start()
            
        }
        
        self.isPaused = false
        
    }
    
    /// Equivalente a *pausar* el reloj
    func stop() {
        
        self.isPaused = true
        
    }
    
    /// Reinicia el reloj
    func reset() {
        
        self.seconds = 0
        
    }
    
    /// Completa el reloj
    ///
    /// En este punto el hilo debería finalizar al salir del `while`
    func done() {
        
        self.isDone = true
        
    }
    
}

/// Para simplificar el manejo de instancias creamos una clase de apoyo
/// para que retenga una instancia global de nuestro Reloj
class AppManager {
    
    static let clockViewModel = ClockViewModel()
    
}

/// Extendemos los enteros para funcionalidad adicional
extension Int {
    
    /// Define una propiedad que devuelve un `String` con el
    /// número entero formateado a 2 dígitos, aumentando el `0` de ser necesario
    var pad: String { self <= 9 ? "0\(self)" : "\(self)" }
    
}

/// Definimos una Vista sencilla con un `UILabel` que muestre el valor del reloj
class SimpleClockViewController: UIViewController {
    
    /// Retenemos los valores que serán actualizados a lo largo del tiempo
    var seconds: Int = 0
    var minutes: Int = 0
    var hours: Int = 0
    
    /// Definimos un `UILabel` para mostrar el valor del reloj
    var clockLabel: UILabel!
    
    /// Al cargar la vista configuramos el `UILabel` en un `UIView`
    override func viewDidLoad() {
        
        // Crea un nuevo `UIView`
        let view = UIView()
        
        // Crea un nuevo `UILabel`
        self.clockLabel = UILabel(frame: CGRect(x: 40, y: 40, width: 100, height: 20))
        
        // Agrega el `UILabel` al `UIView`
        view.addSubview(self.clockLabel)
        
        // Determina que el `UIView` es el principal de esta Vista
        self.view = view
        
        // Actualiza el texto del `UILabel` según el reloj
        self.updateClock()
        
        // Conecta el delegado del Reloj a esta vista
        // Lo que notifique el Reloj será controlado por esta Vista
        AppManager.clockViewModel.delegate = self
        
    }
    
    /// Actualiza el texto del `UILabel` según el reloj
    func updateClock() {
        
        // Calculamos el texto que será actualizado según los valores
        let display = "\(self.hours.pad):\(self.minutes.pad):\(self.seconds.pad)"
        
        print(display)
        
        // Como la actualización podría ocurrir fuera del hilo principal
        // debemos forzar que el `UILabel` se actualice en el hilo
        // principal
        DispatchQueue.main.async {
            
            // Sustituye el texto del `UILabel`
            self.clockLabel.text = display
            
        }
        
    }
    
}

/// El punto crucial del delegado es establecer que esta vista se comporta según el protocolo
///
/// Esto significa que para comportarnos como el delegado, debemos implementar la lógica
/// de las funciones que define el protocolo.
///
/// Esto le permitirá al Reloj confiar que cuándo mande a llamar estos métodos nosotros
/// hagamos lo correcto con los valores que nos esta delegando
extension SimpleClockViewController: ClockViewDelegate {
    
    /// Actualiza los segundos de la Vista y actualiza el `UILabel`
    func clock(updateSeconds seconds: Int) {
        
        self.seconds = seconds
        
        self.updateClock()
        
    }
    
    /// Actualiza los minutos de la Vista y actualiza el `UILabel`
    func clock(updateMinutes minutes: Int) {
        
        self.minutes = minutes
        
        self.updateClock()
        
    }
    
    /// Actualiza las horas de la Vista y actualiza el `UILabel`
    func clock(updateHours hours: Int) {
        
        self.hours = hours
        
        self.updateClock()
        
    }
    
}

// Creamos una prueba unitaria de la Vista

// Definimos una instancia manual de la Vista
let simpleClockViewController = SimpleClockViewController()

// Iniciamos el Reloj
AppManager.clockViewModel.start()

// Ajustamos el Playground para que muestre la Vista
PlaygroundPage.current.liveView = simpleClockViewController
PlaygroundPage.current.needsIndefiniteExecution = true

//: [Next](@next)
