// Heber Eduardo Jimenez Rodriguez
//
// Creado el 27-12-22
//
// Proyecto: TutoriApp
//

// Nombre de segue = goViewController3
// Nombre de esta vista = Pantalla2ViewController

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Modifica el color de la vista
        view.backgroundColor = .brown
        
        // Deslizamiento izquierdo
        // Inicializar el reconocimiento de gestos de deslizamiento
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureAction))
        // Indicamos que sera sensible al movimiento izquierdo
        swipeGesture.direction = .left
        self.view.addGestureRecognizer(swipeGesture)
        view.addGestureRecognizer(swipeGesture)
        
        // Deslizamiento derecho
        // Inicializar el reconocimiento de gestos de deslizamiento
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureActionRight))
        // Indicamos que sera sensible al movimiento derecho
        swipeGestureRight.direction = .right
        self.view.addGestureRecognizer(swipeGestureRight)
        view.addGestureRecognizer(swipeGestureRight)
    }

    // Funcion que detectara el movimiento y enviara a la vista deseada
    @objc func swipeGestureAction(gesture: UISwipeGestureRecognizer) {
        // Al hacer el movimiento a la izquierda nos manda a la vista "goViewController3"
        print(gesture.direction, "Left")
        performSegue(withIdentifier: "goViewController3", sender: self)
    }
    
    // Funcion que detectara el movimiento y realizara el dismiss
    @objc func swipeGestureActionRight(gesture: UISwipeGestureRecognizer) {
        // Al hacer el movimiento a la derecha hace el dismiss
        print(gesture.direction, "Right")
        self.dismiss(animated: true)
    }
}
