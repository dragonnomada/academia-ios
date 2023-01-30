# Recetas de Swift

Por [Alan Badillo Salas](https://www.nomadacode.com)

## 101 - Crear un Protocolo Delegado

Los protocolos permiten abstraer funcionalidad para que las clases y estructuras se comporten como un mismo `tipo funcional`. Estas pueden contener definiciones de propiedades computadas y definiciones de funciones requeridas.

Una clase o estructura que se comporte como un protocolo se limitará a usar la funcionalidad definida en la forma que lo haya implementado.

Esto sirve para que una segunda clase o estructura haga uso de la funcionalidad de otras clases o estructuras que hayan implementado el protocolo, sin entrar en detalles de su implementación.

Esta estrategia sirve para delegar funcionalidad y crear un ecosistema funcional, en el que en cualquier momento se podrá reemplazar la forma en que fue implementada.

Por ejemplo, al modelar una vista abstracta a la que se le pida tener ciertos métodos y propiedades para poder interactuar con ella.

> Ejemplo del protocolo para una *vista abstracta* de un reloj

```swift
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
```

## 102 - Usar el Centro de Notificaciones

El centro de notificaciones (`NotificationCenter`) es un objeto que nos permite publicar objetos (`post`) y observar los objetos publicados (`addObserver`) desde distintas clases.

Esto sirve para que en una clase que actue como modelo o servicio pueda publicar objetos que escuchen otras clases como vistas o presentadores y hagan algo con los objetos que están siendo transmitidos.

Este modelo de eventos permite tener un centro de notificaciones global en el que los objetos están siendo publicados y observados bajo un nombre de evento.

> Ejemplo de un servicio de contador que usa el centro de notificaciones

```swift
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
            
            self.conteoLabel.text = "\(conteo)"
            
        }
        
    }
    
    /// Este método es usado por el observador para llamarse cada
    /// que la notificación `contador.decrementar` sea publicada
    @objc func decrementarObserver(notification: Notification) {
        
        print("Notificación de contador.decrementar")
        
        // Recuperamos el objeto publicado
        // en la notificación para actualizar el `UILabel`
        if let conteo = notification.object as? Int {
            
            self.conteoLabel.text = "\(conteo)"
            
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

// Ajustamos el Playground para que muestre la Vista
PlaygroundPage.current.liveView = contadorViewController
PlaygroundPage.current.needsIndefiniteExecution = true
```

## 103 - Usar de Publicadores de Combine

Los publicadores de `Combine` son mecanismos para poder suscribirnos a los cambios de la propiedad.

Cada que las propiedades cambien su valor, podremos crear un suscriptor de tipo `AnyCancellable`. El publicador expondrá un objeto con prefijo `$` del mismo nombre que la propiedad anotada como `@Published`.

Mediante el método `.sink` del publicador podremos recibir en su clausura el valor de la propiedad y hacer algo al respecto. En cualquier momento podríamos dejar de escuchar los eventos.

> Ejemplo de un servicio de contador que usa publicadores de *Combine*

```swift
/// Un servicio es aquél responsable de mantener un estado y notificar
/// cuándo ocurren eventos o cambios dentro del estado.
///
/// El servicio `ContadorService` es responsable de incrementar
/// y decrementar un conteo
class ContadorService {
    
    /// Las propiedades marcadas como `@Published` generan
    /// automáticamente un suscriptor del mismo nombre pero con
    /// el prefijo `$`, en este caso será `$conteo`.
    ///
    /// A través del publicador `$conteo` podremos hacer la
    /// suscripción de tipo `AnyCancellable` y `.sink { ... }`
    /// para escuchar cada que la propiedad cambie.
    @Published var conteo: Int = 0
    
    /// Incrementa la propiedad conteo
    func incrementar() {
        
        // Al modificar esta propiedad, automáticamente
        // se enviará una notificación a los suscriptores
        self.conteo += 1
        
    }
    
    /// Decrementa la propiedad conteo
    func decrementar() {
        
        // Al modificar esta propiedad, automáticamente
        // se enviará una notificación a los suscriptores
        self.conteo -= 1
        
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
    
    /// Los suscriptores de tipo `AnyCancellable` permitirán
    /// escuchar los eventos de cambio y ser cancelados en cualquier
    /// momento mediante `.cancel()`
    var conteoSubscriber: AnyCancellable?
    
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
        
        // Creamos el suscriptor a través del publicador
        // `$conteo` generado automáticamente y su
        // método `.sink`, el cuál recibe una clausura
        // o función que procesa cada valor recibido
        // por el publicador, cuando el valor cambia
        self.conteoSubscriber = AppManager.contadorService.$conteo.sink(receiveValue: {
            
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
                self?.conteoLabel.text = "\(conteo)"
                
            }
            
        })
        
    }
    
    /// Al destruirse esta vista debemos dejar de observar las publicaciones
    /// a las que nos suscribimos
    deinit {
        
        // Cancelamos la suscripción
        self.conteoSubscriber?.cancel()
        // Liberamos la propiedad
        self.conteoSubscriber = nil
        
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
```

## 104 - Usar de Sujetos de Combine

Los sujetos son similares a los publicadores, sin embargo, en lugar de notificar los cambios sobre una propiedad, lo que hacemos es escuchar cada que un objeto es enviado al sujeto.

Un sujeto puede tener múltiples suscriptores que mediante `.sink` escuchen el objeto pasado a través del sujeto.

Esto es también similar al `NotificationCenter` pero en un modo más formal.

> Ejemplo de un servicio de contador que usa sujetos de *Combine*

```swift
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
                self?.conteoLabel.text = "\(conteo)"
                
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
                self?.conteoLabel.text = "\(conteo)"
                
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
```

# 105 - Uso de Alertas

Las alertas son pantallas flotantes prediseñadas que se pueden utilizar para mostrar mensajes y acciones al usuario.

Cada acción debe ser registrada en la alerta y esta se puede mostrar como una ventana de acciones o como una alerta clásica.

> Ejemplo de una alerta clásica

```swift
let alert = UIAlertController(title: "Alerta simple", message: "Esta es una alerta simple 😁", preferredStyle: .alert)
        
alert.addAction(UIAlertAction(title: "Oki Doki", style: .default))

self.present(alert, animated: true)
```
