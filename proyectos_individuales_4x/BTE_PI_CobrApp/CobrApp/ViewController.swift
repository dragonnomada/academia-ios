//
//  ViewController.swift
//  CobrApp
//  Desarrollo de una aplicacion que codigo QR conectada a una API
//  Created by Eduardo Batista on 28/12/22.
//

import UIKit

/// Modelo de la respuesta para un usuario Api con el protocolo Decodeable con Usuario Respuesta
struct UsuarioResponse : Decodable {
    let error: Bool
    let message: String
    let user: UsuarioData?
    
}
//
struct UsuarioData : Decodable {
    let username: String
    let password: String
    let token: String
}


class ViewController: UIViewController {

    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var contraseñaTextField: UITextField!
    
    var user: String = ""
    var token: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    /// Preparamos la funcion prepare para mandar a QRViewController un usuario y un token
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Login-QR-Segue" {
            let destination = segue.destination as! QRViewController
            destination.usuario = self.user
            destination.token = self.token
        }
    }
    
    
    
    @IBAction func ingresarActionPress(_ sender: Any) {
        let username = usuarioTextField.text!
        let password = contraseñaTextField.text!
        
        // Recibe los texfield correspondientes para iniciar sesion
        self.Login(username: username.lowercased(), password: password)
    }
    /// La función Login se contecta ala Api que validará que el usuario y contreseña  y la URL sean correctas
    func Login(username: String, password: String) {
        
        let userURL = "http://34.125.242.89/api/cobrapp/login?username=\(username)&password=\(password)"
        
        guard let url = URL(string: userURL) else { return }
        
        let session = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print("Error De inicio de Sesion \(error)")
            }
            if let data = data {
                do {
                    // Decodifica respuesta JSON
                    let response = try JSONDecoder().decode(UsuarioResponse.self, from: data)
                    // Si en la respuesta existe un Error Manda alertas a la vista
                    if response.error {
                        DispatchQueue.main.sync {
                            
                            // Generamos las alertas Datos incorrectos y los enviamos
                            let alert = UIAlertController(title: "Datos Incorrectos", message: "Verifica nombre de usuario y contraseña", preferredStyle: .alert)
                            
                            let cancelBotton = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
                            
                            alert.addAction(cancelBotton)
                            
                            self.present(alert, animated: true, completion: nil)
                        }

                    } else {
                        DispatchQueue.main.sync {
                            // Asigamos de forma sincrona, los valores a nuestro Usuario como variable global para que posteriormente enviarla en el prepare
                            
                            self.user = response.user?.username ?? "NIL QR USERNAME"
                            self.token = response.user?.token ?? "NIL QR TOKEN"
                             
                            
                            // Navegamos a la sigueente vista despues de validar el usuario la contraseña y que existe una respuesta
                            self.performSegue(withIdentifier: "Login-QR-Segue", sender:nil)
                        }
                    }
                    } catch {
                                
                        print("JSON Error DATA \(error)")
                    }
                }
            }
        session.resume()
        }
    
}
