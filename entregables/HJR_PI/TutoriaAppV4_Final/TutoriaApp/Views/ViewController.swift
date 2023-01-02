// Heber Eduardo Jimenez Rodriguez
//
// Creado el 27-12-22
//
// Proyecto: TutoriApp
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Modifica el color de la vista
        view.backgroundColor = .brown
        
        // Deslizamiento izquierdo
        // Inicializar el reconocimiento de gestos de deslizamiento
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureAction))
        // Indicamos que sera sensible al movimiento izquierd0
        swipeGestureLeft.direction = .left
        self.view.addGestureRecognizer(swipeGestureLeft)
        view.addGestureRecognizer(swipeGestureLeft)
        
        // Deslizamiento derecho
        // Inicializar el reconocimiento de gestos de deslizamiento
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureActionRight))
        // Indicamos que sera sensible al movimiento derech0
        swipeGestureRight.direction = .right
        self.view.addGestureRecognizer(swipeGestureRight)
        view.addGestureRecognizer(swipeGestureRight)
    }
    
    // Funcion que detectara el movimiento izquierdo y enviara ala vista deseada
    @objc func swipeGestureAction(gesture: UISwipeGestureRecognizer) {
        // Al hacer el movimiento a la izquierda nos manda a la vista "goViewController2"
        print(gesture.direction, "Left")
        performSegue(withIdentifier: "goViewController2", sender: self)
    }
    
    // Funcion que detectara el movimiento derecho y enviara a la vista deseada
    @objc func swipeGestureActionRight(gesture: UISwipeGestureRecognizer) {
        // Al hacer el movimiento a la derecha, nos proporciona una alerta en pantalla
        // Configuracion de alerta
        let alerta = UIAlertController(title: "ERROR", message: "No se puede hacer dismiss a esta pagina", preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        present(alerta, animated: true)
    }
}
