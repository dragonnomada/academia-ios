/*
 Heber Eduardo Jimenez Rodriguez
 
 Creado el 27-12-22
 
 Proyecto: TutoriApp
 */

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Modifica el color de la vista
        view.backgroundColor = .brown
        
        // Inicializar el reconocimiento de gestos de deslizamiento
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureAction))
        // Indicamos que sera sensible al movimiento de derecha a izquierda
        swipeGestureLeft.direction = .left
        self.view.addGestureRecognizer(swipeGestureLeft)
        view.addGestureRecognizer(swipeGestureLeft)
        
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
        performSegue(withIdentifier: "goViewController2", sender: self)
    }
    
    // Funcion derecha
    @objc func swipeGestureActionRight(gesture: UISwipeGestureRecognizer) {
        // Al hacer el movimiento a la izquierda, imprime el texto dado
        // y nos manda a la vista "goViewController2"
        print(gesture.direction, "Right")
        
        // Configuracion de alerta
        let alerta = UIAlertController(title: "ERROR", message: "No se puede hacer dismiss a esta pagina", preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        present(alerta, animated: true)
    }
}


// Ejemplo de la pantallita negra

/*
 // Configuracion de una instacia de la vista
 private let swipeableView: UIView = {
     
     // Inicializacion de la vista, pasandole la anchura y la altura
     let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 300.0, height: 400.0)))
     
     // Configuracion del color de la vista
     view.backgroundColor = UIColor.black
     // No queremos usar diseño automatico patra el tamaño y posicion de la vista
     view.translatesAutoresizingMaskIntoConstraints = true
     
     return view
 }()
 
 override func viewDidLoad() {
     super.viewDidLoad()
     
     // Añadir a la jerarquía de vistas
     view.addSubview(swipeableView)
     
     // Crear reconocedores de gestos de deslizamiento
     //swipeableView.addGestureRecognizer(createSwipeGestureRecognizer(for: .up))
     //swipeableView.addGestureRecognizer(createSwipeGestureRecognizer(for: .down))
     swipeableView.addGestureRecognizer(createSwipeGestureRecognizer(for: .left))
     swipeableView.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
     
     // Inicializar el reconocimiento de gestos de deslizamiento
     let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
     
     // Configurar el reconocedor de gestos de deslizamiento
     swipeGestureRecognizerDown.direction = .right
     
     // Agregar reconocimiento de gestos de deslizamiento
     swipeableView.addGestureRecognizer(swipeGestureRecognizerDown)
 }
 
 // MARK: - Actions
 
 @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
     
     // Fotograma actual
     var frame = swipeableView.frame
     
     switch sender.direction {
     case .up:
         frame.origin.y -= 10.0
         frame.origin.y = max(0.0, frame.origin.y)
     case .down:
         frame.origin.y += 100.0
         
         if frame.maxY > view.bounds.maxY {
             frame.origin.y = view.bounds.height - frame.height
         }
     case .left:
         frame.origin.x -= 100.0
         frame.origin.x = max(0.0, frame.origin.x)
     case .right:
         frame.origin.x += 100.0
         
         if frame.maxX > view.bounds.maxX {
             frame.origin.x = view.bounds.width - frame.width
         }
     default:
         break
     }
     
     UIView.animate(withDuration: 0.25) {
         self.swipeableView.frame = frame
     }
 }
 
 // MARK: - Helper Methods
 
 private func createSwipeGestureRecognizer(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
     
     // Inicializar el reconocimiento de gestos de deslizamiento
     let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
     
     // Configurar el reconocedor de gestos de deslizamiento
     swipeGestureRecognizer.direction = direction
     
     return swipeGestureRecognizer
     
 }
*/
