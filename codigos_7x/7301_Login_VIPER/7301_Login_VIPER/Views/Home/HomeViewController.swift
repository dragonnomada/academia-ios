//
//  HomeViewController.swift
//  7301_Login_VIPER
//
//  Created by Dragon on 18/01/23.
//

import UIKit

class HomeViewController: UIViewController {

    weak var presenter: HomePresenter?
    
    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    deinit {
        print("LIBERANDO HomeViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter?.requestUserLogged()
    }
    
    @IBAction func signOutAction() {
        
        self.presenter?.signOut() {
            
            return true
            
        }
        
    }

}

extension HomeViewController: HomeView {
    
    func home(willOpen: Bool) {
        print("Abriendo ventana Home [presenter? \(self.presenter != nil ? "SI" : "NO")]")
    }
    
    func home(userSignIn: UserEntity) {
        
        self.welcomeLabel.text = "Welcome\n\(userSignIn.fullname)"
        
        if let picture = userSignIn.picture {
            
            self.pictureImageView.image = UIImage(data: picture)
            
        }
        
    }
    
    func home(userSignOut: UserEntity) {
        
        print("El usuario cerró sesión")
        
        let alert = UIAlertController(title: "Sesión cerrada", message: "Adiós", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {
            
            [weak self] _ in
        
            self?.presenter?.goToLogin()
            
        }))
        
        self.present(alert, animated: true)
        
    }
    
}
