//
//  ViewController3.swift
//  TutoriaApp
//
//  Created by MacBook on 27/12/22.

// Nombre de segue = goVideosViewController
// Nombre de la segunda pantalla = VideosViewController
//

import UIKit

class ViewController3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureAction))
        swipeGesture.direction = .left
        
        view.addGestureRecognizer(swipeGesture)
    }
    @objc func swipeGestureAction(gesture: UISwipeGestureRecognizer) {
        
        print(gesture.direction, "Left")
        performSegue(withIdentifier: "goVideosViewController", sender: self)
    }
}
