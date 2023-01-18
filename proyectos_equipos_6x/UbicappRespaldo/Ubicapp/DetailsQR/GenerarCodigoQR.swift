//
//  GenerarCodigoQR.swift
//  Ubicapp
//
//  Created by MacBook  on 12/01/23.
//

import Foundation
import UIKit

func generarCodigoQR(from string: String) -> UIImage? {
    var image: UIImage? = nil
    // codificar el string que resibimos como parametro, ocupando ascii
    let data: Data? = string.data(using: .ascii)
    
    // generamos un filtro que nos va ayudar a generar el ciclo qr.
    
    if let filtro = CIFilter(name: "CIQRCodeGenerator"){
        // establecemos la entrada del filtro o los datos que se van acodificar para formar el codigo QR
        filtro.setValue(data, forKey: "inputMessage")
        
       let transformacion = CGAffineTransform(scaleX: 3, y: 3)
        
        if let outputImage = filtro.outputImage?.transformed(by: transformacion){
            image = UIImage(ciImage: outputImage)
        }
        
    }
    return image
}
