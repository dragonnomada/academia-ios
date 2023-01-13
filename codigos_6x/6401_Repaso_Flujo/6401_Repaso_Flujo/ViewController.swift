//
//  ViewController.swift
//  6401_Repaso_Flujo
//
//  Created by Dragon on 12/01/23.
//

import UIKit
import Combine

class MyModel {
    
    // Datos retenidos y sus Publicadores
    
    @Published var text: String?
    
    func updateText(text: String) {
        self.text = "[\(Date.now)] \(text)"
    }
    
}

// Class-Bound (el protocolo se comporta como clase)
protocol MyView: NSObject {
    
    // Métodos para notificarle cosas a la vista
    
    func notify(text: String)
    
}

class MyViewModel {
    
    // Conectar una vista a un modelo
    // y el modelo a la vista
    
    // Esta es la vista
    weak var view: MyView?
    
    // Este es el modelo
    var model: MyModel?
    
    // Esto es lo que escuchamos del modelo
    var textModelSubscriber: AnyCancellable?
    
    // Al crear el View-Model suscribimos las
    // cosas que le pasan al modelo con el que nos construimos
    init(model: MyModel) {
        self.model = model
        
        self.textModelSubscriber = model.$text.sink {
            [weak self] text in
            // TODO: Notificar a la vista que ya tenemos el texto
            if let text = text {
                self?.view?.notify(text: text)
            } else {
                self?.view?.notify(text: "SIN TEXTO :/")
            }
        }
    }
    
    // Esta es la función que puede consumir la vista (el ViewController)
    func updateText(text: String) {
        self.model?.updateText(text: text)
    }
    
}

class ViewController: UIViewController {
    
    // Dependo que alguien me de la instancia del View-Model :(
    weak var viewModel: MyViewModel?
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let viewModel = self.viewModel {
            viewModel.view = self
        }
        
        self.viewModel?.updateText(text: "Esperando...")
        
        if let url = URL(string: "https://google.com") {
        
            // THREAD: ViewController (main)
            
            let session = URLSession.shared.dataTask(with: url) {
                [weak self] data, response, error in
                
                if let error = error {
                    print("No se pudo descargar la URL. Error: \(error)")
                    // TODO: Notificarle a mi View-Model que hubo un error
                    return
                }
                
                guard let data = data else {
                    print("No hay datos por descargar desde la URL.")
                    // TODO: Notificarle a mi View-Model que no hay datos
                    return
                }

                // TODO: Notificarle a mi View-Model que hay datos (texto nuevo)
                
                DispatchQueue.main.async {
                    self?.viewModel?.updateText(text: "\(data)")
                }
                
                // THREAD: URLSession.shared.dataTask (no main)
                
                // 1. ESTAMOS DENTRO DE UNA CLAUSURA
                // 2. SI UTILIZAMOS SELF LA CLAUSURA LO CAPTURA
                // 3. EL USAR WEAK SELF NO ES UNA SOLUCIÓN COMPLETA
                //    Porque [weak self] sólo verfica que cuándo
                //    la clausura sea llamada, el self aún exista,
                //    Por ejemplo tras 30 segundos se ejecuta
                //    esta clausura con la respuesta del servidor
                //    pero ya cambiamos de vista y podría ya no
                //    existir el self.
                //    Sin el [weak self] se mandría vivo a self
                //    con una referencia más hasta que termine
                //    esta clausura.
                // 4. EL HILO LE PERTENECE A LA CLAUSURA
                //    Las clausuras son como portales de código
                //    que ejecutan lo definido en la clausura
                //    en otra parte del código.
                //    Esto significa que la ejecución y uso de self
                //    se dará en otro lado y
                //    "posiblemente en otro hilo".
                //    Los componentes visuales tienen la restricción
                //    de ejecutuarse únicamente en el hilo principal
                //    O en el hilo del `ViewController`.
                //    Si *self* es capturado tenemos el riesgo
                //    de usar cotroles visuales fuera del hilo
                //    permitido (main).
                //    Aunque podemos usar `DispactchQueue.main.async`
                //    No es la mejor manera de notificarle
                //    a la vista que un componente visual necesita
                //    actualizarse.
                
                // CONCLUSIONES:
                // * No es buena práctica usar `self` dentro de
                // una clausura. Porque corremos el riesgo
                // de operar en otro hilo y aumentar las referencias
                // al `self`
                // * Una alternativa (no-solución) es usar
                //   [weak self] para no aumentar las referencias,
                //   pero no soluciona el problema de haber cambiado
                //   de hilo.
                // * La mejor práctica será no utilizar `self` dentro
                //   de las clausuras. Por lo que debemos
                //   notificarle los cambios visuales o relacionados
                //   al `self` a otro componente como podría ser
                //   un controlador, un vista-modelo o un presentador
                //   esto lo conseguimos mediante protocolos
                //   en el concepto de delagados.
                
            }
            
            print("Se hizo el dataTask")
            
            session.resume()
            
        }
        
        print("SIGUE")
    }

}

extension ViewController: MyView {
    
    func notify(text: String) {
        self.myLabel.text = text
    }
    
}
