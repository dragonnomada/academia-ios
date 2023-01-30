//
//  AddViewDelegate.swift
//  HomeModule
//
//  Created by User on 27/01/23.
//

import Foundation
import UIKit

protocol AddViewDelegate: UIViewController {
    
    var presenter: AddPresenter? { get set }
    
    func viewWillCreate()
    
    func viewDidCreate()
    
    func viewWillRemove()
    
    func foods(foodCreated food: FoodEntity)
    
}

extension AddViewDelegate {
    
    func viewWillCreate() {}
    
    func viewDidCreate() {}
    
    func viewWillRemove() {}
    
}
