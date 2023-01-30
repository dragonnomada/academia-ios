//
//  LoginUserViewController.swift
//  ProfileModule
//
//  Created by MacBook on 27/01/23.
//

import UIKit

class LoginUserViewController: UIViewController {

    weak var presenter: LoginUserPresenter?
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var iconClick = true
    let imageIcon = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageIcon.image = UIImage(named: "closeeye")
        
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        
        contentView.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        
        imageIcon.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        passwordTextField.rightView = contentView
        passwordTextField.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
      
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if iconClick {
            
            iconClick = false
            tappedImage.image = UIImage(named: "openeye")
            passwordTextField.isSecureTextEntry = false
            
        } else {
            
            iconClick = true
            tappedImage.image = UIImage(named: "closeeye")
            passwordTextField.isSecureTextEntry = true
            
        }
        
    }
    
    
    @IBAction func logInActionButton(_ sender: Any) {
        
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            
            if email == "" {
                
                let alert = UIAlertController(title: "Login Failed", message: "Please insert a valid email", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true)
                
                return
                
            }
            
            if password == "" {
                
                let alert = UIAlertController(title: "Login Failed", message: "Please insert a valid password", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true)
                
                return
                
            }
            
            self.presenter?.loginUser(email: email, password: password)
            
        }
        
        
    }
    
    @IBAction func signInActionButton(_ sender: Any) {
        
        self.presenter?.goToRegister()
        
    }
    
}

extension LoginUserViewController: LoginUserDelegate {
    
    func userLoggedFailed(userLoggedFailed: Error) {
        
        print("Error al logear")
        
        let alert = UIAlertController(title: "User Logged Failed", message: "email or password or both didn't match with database", preferredStyle: .alert)
                
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            
            NotificationCenter.default.post(name: NSNotification.Name("foodapp.login.failed"), object: self)
            
            
        } ))

        self.present(alert, animated: true)
        
    }
    
    
    func userLogged(userLogged: UserAuthInfoEntity) {
        
        print("Exito al logear")
        
        let alert = UIAlertController(title: "User Logged Succesfully", message: "the user has been logged succesfully", preferredStyle: .alert)
                
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            
            NotificationCenter.default.post(name: NSNotification.Name("foodapp.login.succes"), object: self)
            
            
        } ))

        self.present(alert, animated: true)
        
    }
    
}
