//
//  ViewController.swift
//  6201_Animation
//
//  Created by Dragon on 10/01/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    
    var radiusAnimator: UIViewPropertyAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*UIView.animate(withDuration: 5, delay: 0, options: .curveEaseOut) {
            
            // TODO: Hacemos las animaciones
            
            //self.myImageView.alpha = 0
            
            //self.myImageView.bounds = CGRect(x: self.myImageView.bounds.midX, y: self.myImageView.bounds.midY, width: 20, height: 20)
            
            self.myImageView.layer.cornerRadius = self.myImageView.bounds.size.width / 2
            
            self.view.backgroundColor = UIColor(red: 1, green: 1, blue: 0, alpha: 1)
            
        } completion: { success in
            print("Animación terminada (redondeada): \(success)")
            
            
            UIView.animate(withDuration: 5, delay: 0, options: .curveEaseIn) {
                self.myImageView.layer.cornerRadius = self.myImageView.bounds.size.width
                
                self.view.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
                
            } completion: { success in
                print("Animación terminada (cuadrada): \(success)")
            }

        }*/
        
        //self.myImageView.alpha = 0
        
        radiusAnimator = UIViewPropertyAnimator(duration: 5, curve: .easeIn) {
            self.myImageView.layer.cornerRadius = self.myImageView.bounds.size.width / 2
        }
        
    }

    @IBAction func startAnimationAction(_ sender: Any) {
        
        self.radiusAnimator?.startAnimation()
        
    }
    
}

