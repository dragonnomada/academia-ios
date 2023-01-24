//
//  ViewController.swift
//  8201_Apoyo_Firebase_Edamam
//
//  Created by MacBook  on 24/01/23.
//

import UIKit
import Combine

class ViewController: UIViewController {

    let service = FirebaseService()
    
    @IBOutlet weak var registerEmailTextField: UITextField!
    
    @IBOutlet weak var registerPasswordTextField: UITextField!
    
    @IBOutlet weak var signInEmailTextField: UITextField!
    
    @IBOutlet weak var signInPasswordTextField: UITextField!
    
    @IBOutlet weak var signInRememberSwitch: UISwitch!
    
    @IBOutlet weak var infoNameTextField: UITextField!
    
    @IBOutlet weak var userInfoLabel: UILabel!
    
    var isValidEmailSubscriber: AnyCancellable?
    var isValidPasswordSubscriber: AnyCancellable?
    var createUserCredentialSubscriber: AnyCancellable?
    var createUserInfoSubscriber: AnyCancellable?
    var signInSubscriber: AnyCancellable?
    var autoSignInSubscriber: AnyCancellable?
    var signOutSubscriber: AnyCancellable?
    var userRememberedSubscriber: AnyCancellable?
    
    func subscribeSignIn() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isValidEmailSubscriber = service.isValidEmailSubject.sink {

            userCredential, error in

            if let error = error {
                print("[isValidEmailSubscriber] Error: \(error)")
            }

            if let userCredential = userCredential {
                print("[isValidEmailSubscriber] \(userCredential)")
            }

        }

        self.isValidPasswordSubscriber = service.isValidPasswordSubject.sink {

            userCredential, error in

            if let error = error {
                print("[isValidPasswordSubscriber] Error: \(error)")
            }

            if let userCredential = userCredential {
                print("[isValidPasswordSubscriber] \(userCredential)")
            }

        }

        self.createUserCredentialSubscriber = service.createUserCredentialSubject.sink {

            userCredential, error in

            if let error = error {
                print("[createUserCredentialSubscriber] Error: \(error)")
            }

            if let userCredential = userCredential {
                print("[createUserCredentialSubscriber] \(userCredential)")
            }

        }

        self.createUserInfoSubscriber = service.createUserInfoSubject.sink {

            userInfo, error in

            if let error = error {
                print("[createUserInfoSubscriber] Error: \(error)")
            }

            if let userInfo = userInfo {
                print("[createUserInfoSubscriber] \(userInfo)")
            }

        }

        self.signInSubscriber = service.signInSubject.sink {

            userCredential, error in

            if let error = error {
                print("[signInSubscriber] Error: \(error)")
            }

            if let userCredential = userCredential {
                print("[signInSubscriber] \(userCredential)")
                
                var text = ""
                
                text += "Correo: \(userCredential.email ?? "SIN EMAIL")\n"
                text += "Recordado: \(userCredential.isActiveRemember ? "SI" : "NO")\n"
                
                if let userInfo = userCredential.userInfo {
                    
                    text += "Nombre: \(userInfo.name ?? "SIN NOMBRE")\n"
                    text += "Foto: \(userInfo.picture?.count ?? 0) bytes\n"
                    
                }
                
                text += "Último inicio: \(userCredential.signedAt ?? Date.now)\n"
                
                self.userInfoLabel.text = text
                
            }

        }

        self.autoSignInSubscriber = service.autoSignInSubject.sink {

            userCredential, error in

            if let error = error {
                print("[autoSignInSubscriber] Error: \(error)")
            }

            if let userCredential = userCredential {
                print("[autoSignInSubscriber] \(userCredential)")
            }

        }

        self.signOutSubscriber = service.signOutSubject.sink {

            userCredential, error in

            if let error = error {
                print("[signOutSubscriber] Error: \(error)")
            }

            if let userCredential = userCredential {
                print("[signOutSubscriber] \(userCredential)")
            }

        }

        self.userRememberedSubscriber = service.userRememberedSubject.sink {

            userCredential, error in

            if let error = error {
                print("[userRememberedSubscriber] Error: \(error)")
            }

            if let userCredential = userCredential {
                print("[userRememberedSubscriber] \(userCredential)")
                
                // Iniciamos sesión automáticamente con el usuario recordado
                if let uid = userCredential.uid {
                    self.service.autoSignIn(uid: uid)
                }
                
            }

        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.service.getLastSignedUserRemember()
        
    }

    @IBAction func registerAction(_ sender: Any) {
        
        guard let email = self.registerEmailTextField.text else {
            return
        }
        
        guard let password = self.registerPasswordTextField.text else {
            return
        }
        
        self.service.createUserCredential(email: email, password: password)
        
    }
    
    @IBAction func signInAction(_ sender: Any) {
        
        guard let email = self.signInEmailTextField.text else {
            return
        }
        
        guard let password = self.signInPasswordTextField.text else {
            return
        }
        
        self.service.signIn(withEmail: email, password: password, remember: signInRememberSwitch.isOn)
        
    }
    
    @IBAction func addInfoAction(_ sender: Any) {
        
        guard let name = self.infoNameTextField.text else {
            return
        }
        
        self.service.createUserInfo(name: name, picture: nil)
        
    }
    
    @IBAction func signOutAction(_ sender: Any) {
        
        self.service.signOut()
        
    }
    
}

