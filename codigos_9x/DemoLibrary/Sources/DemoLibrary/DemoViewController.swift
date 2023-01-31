//
//  DemoViewController.swift
//  
//
//  Created by MacBook  on 31/01/23.
//

import UIKit

public class DemoViewController: UIViewController {

    public static func getInstance() -> DemoViewController {
        
        return DemoViewController(nibName: "DemoViewController", bundle: Bundle.module)
        
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
