//
//  BViewController.swift
//  4301_Repaso_segues
//
//  Created by User on 28/12/22.
//

import UIKit

class BViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func irDDeBAction(_ sender: Any) {
        self.performSegue(withIdentifier: "Ir a D de B", sender: nil)
    }
    
    @IBAction func regresarAction(_ sender: Any) {
        self.dismiss(animated: true)
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
