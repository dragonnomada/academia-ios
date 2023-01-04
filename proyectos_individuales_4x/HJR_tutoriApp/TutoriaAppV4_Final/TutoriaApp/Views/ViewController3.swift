// Heber Eduardo Jimenez Rodriguez
//
// Creado el 27-12-22
//
// Proyecto: TutoriApp
//
// Nombre de segue = goVideosViewController
// Nombre de la segunda pantalla = VideosViewController
//

import UIKit

class ViewController3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Modifica el color de la vista
        view.backgroundColor = .brown
        
        // Inicializar el reconocimiento de gestos de deslizamiento
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureAction))
        // Indicamos que sera sensible al movimiento izquierdo
        swipeGesture.direction = .left
        
        self.view.addGestureRecognizer(swipeGesture)
        
        view.addGestureRecognizer(swipeGesture)
        
        // Inicializar el reconocimiento de gestos de deslizamiento
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureActionRight))
        // Indicamos que sera sensible al movimiento derecho
        swipeGestureRight.direction = .right
        self.view.addGestureRecognizer(swipeGestureRight)
        view.addGestureRecognizer(swipeGestureRight)
    }
    
    // Funcion que detectara el movimiento y enviara a la vista deseada
    @objc func swipeGestureAction(gesture: UISwipeGestureRecognizer) {
        // Al hacer el movimiento a la izquierda, imprime el texto dado
        // y nos manda a la vista "goViewController2"
        print(gesture.direction, "Left")
        performSegue(withIdentifier: "goVideosViewController", sender: self)
    }
    
    // Funcion que detectara el movimiento
    @objc func swipeGestureActionRight(gesture: UISwipeGestureRecognizer) {
        // Al hacer el movimiento a la derecha hace el dimiss
        print(gesture.direction, "Right")
        self.dismiss(animated: true)
    }
}
