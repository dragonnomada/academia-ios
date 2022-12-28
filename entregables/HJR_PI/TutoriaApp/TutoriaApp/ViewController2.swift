//
//  Pantalla2ViewController.swift
//  TutoriaApp
//
//  Created by MacBook on 27/12/22.
// goPantalla3
// Nombre de segue = goViewController3
// Nombre de la segunda pantalla = Pantalla2ViewController

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureAction))
        swipeGesture.direction = .left
        
        view.addGestureRecognizer(swipeGesture)
    }
    @objc func swipeGestureAction(gesture: UISwipeGestureRecognizer) {
        
        print(gesture.direction, "Left")
        performSegue(withIdentifier: "goViewController3", sender: self)
    }
}
