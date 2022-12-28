//
//  BViewController.swift
//  4302_sigues_envio_Datos
//
//  Created by MacBook  on 28/12/22.
//

import UIKit

class BViewController: UIViewController {

    // estamos preparamos para resivir una fruta en la pantalla B
    //recordemos que es obcional
    var fruta: Fruta?
    
    
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var price: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let fruta = fruta{
            print("[pantalla b] he resivido la fruta : \(fruta)")
            
            name.text = fruta.nombre
            price.text = "\(fruta.peso) KG"
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
