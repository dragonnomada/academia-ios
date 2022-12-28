//
//  DViewController.swift
//  4301_RepasoDeSigues
//
//  Created by MacBook  on 28/12/22.
//

import UIKit

class DViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func gotoBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func goToC(_ sender: Any) {
        self.performSegue(withIdentifier: "DtoC", sender: nil)
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
