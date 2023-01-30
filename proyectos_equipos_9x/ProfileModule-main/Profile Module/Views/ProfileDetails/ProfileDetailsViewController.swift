//
//  ProfileDetailsViewController.swift
//  Profile Module
//
//  Created by MacBook Pro on 27/01/23.
//

import UIKit

class ProfileDetailsViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    
    @IBOutlet weak var profileEmailLabel: UILabel!
    
    
    @IBOutlet weak var qrImageView: UIImageView!
    
    
    var presenter: ProfileDetailsPresenter?
    
    var profile: ProfileEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.requestProfile()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        //
        //self.presenter?.requestProfile()
    }
    
    
    @IBAction func EditButtonAction(_ sender: Any) {
        self.presenter?.gotoProfileEdit()
    }
    
    func generarQR(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }

}

extension ProfileDetailsViewController: ProfileDetailsViewDelegate {
    func profile(profileCreated profile: ProfileEntity) {
        if let image = profile.imageProfile  {
            self.profileImageView.image = UIImage(data: image)
        }
        
        self.profileNameLabel.text = profile.nameProfile
        
        if let email = profile.emailProfile {
            self.profileEmailLabel.text = email
            self.qrImageView.image = generarQR(from: "mailto:\(email)")
        }
        
    }

    
}
