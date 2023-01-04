/*
 Heber Eduardo Jimenez Rodriguez
 
 Creado el 27-12-22
 
 Proyecto: TutoriApp
 */

// Nombre de segue = goViewController3
// Nombre de esta vista = Pantalla2ViewController

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Modifica el color de la vista
        view.backgroundColor = .brown
        
        // Inicializar el reconocimiento de gestos de deslizamiento
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureAction))
        // Indicamos que sera sensible al movimiento de derecha a izquierda
        swipeGesture.direction = .left
        
        self.view.addGestureRecognizer(swipeGesture)
        
        view.addGestureRecognizer(swipeGesture)
        
        // Gesto derecho
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureActionRight))
        // Indicamos que sera sensible al movimiento de derecha a izquierda
        swipeGestureRight.direction = .right
        
        self.view.addGestureRecognizer(swipeGestureRight)
        
        view.addGestureRecognizer(swipeGestureRight)
    }

    // Funcion que detectara el movimiento y enviara a la vista deseada
    @objc func swipeGestureAction(gesture: UISwipeGestureRecognizer) {
        // Al hacer el movimiento a la izquierda, imprime el texto dado
        // y nos manda a la vista "goViewController2"
        print(gesture.direction, "Left")
        performSegue(withIdentifier: "goViewController3", sender: self)
    }
    
    // Funcion derecha
    @objc func swipeGestureActionRight(gesture: UISwipeGestureRecognizer) {
        // Al hacer el movimiento a la izquierda, imprime el texto dado
        // y nos manda a la vista "goViewController2"
        print(gesture.direction, "Right")
        self.dismiss(animated: true)
    }
}
