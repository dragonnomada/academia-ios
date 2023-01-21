//
//  HomeViewController.swift
//  TestFireBase
//
//  Created by MacBook on 20/01/23.
//

import UIKit
import FirebaseAuth

enum ProviderType: String {
    
    case email_password
    
}

class HomeViewController: UIViewController {

    private let email: String
    private let provider: ProviderType
    
    @IBOutlet weak var EmailUserLabel: UILabel!
    
    @IBOutlet weak var proveedorLabel: UILabel!
    
    init(email: String, provider: ProviderType ) {
        self.email = email
        self.provider = provider
        super.init(nibName: nil, bundle: nil )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"
        
        EmailUserLabel.text = email
        proveedorLabel.text = provider.rawValue
    }
    

    @IBAction func closeSessionActionButton(_ sender: Any) {
        
        switch provider {
            
        case .email_password:
            do {
                
                try Auth.auth().signOut()
                navigationController?.popViewController(animated: true)
                
            } catch {
                //TODO ALERTA
            }
        }
        
    }
    

}
 
