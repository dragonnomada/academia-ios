//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

class MyViewController: UIViewController {
    
    var showSimpleAlertButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let view = UIView()
        
        self.showSimpleAlertButton = UIButton(frame: CGRect(x: 20, y: 20, width: 300, height: 20))
        
        self.showSimpleAlertButton.setTitle("Mostrar alerta simple", for: .normal)
        self.showSimpleAlertButton.setTitleColor(.systemPink, for: .normal)
        self.showSimpleAlertButton.addTarget(self, action: #selector(self.showSimpleAlertAction), for: .touchUpInside)
        
        view.addSubview(self.showSimpleAlertButton)
        
        self.view = view
        
    }
    
    @objc func showSimpleAlertAction() {
        
        let alert = UIAlertController(title: "Alerta simple", message: "Esta es una alerta simple 😁", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Oki Doki", style: .default))
        
        self.present(alert, animated: true)
        
    }
    
}

PlaygroundSupport.PlaygroundPage.current.liveView = MyViewController()

//: [Next](@next)
