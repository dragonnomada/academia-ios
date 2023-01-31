//
//  HomeViewController.swift
//  MyCaloriAPP
//
//  Created by User on 23/01/23.
//

import UIKit

class HomeViewController: UIViewController {

    weak var presenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }

}

extension HomeViewController: HomeView {
    
}
