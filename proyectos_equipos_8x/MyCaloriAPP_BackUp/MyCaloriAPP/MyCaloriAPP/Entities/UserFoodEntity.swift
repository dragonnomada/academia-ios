//
//  UserDietEntity.swift
//  MyCaloriAPP
//
//  Created by User on 23/01/23.
//

import Foundation
import UIKit


struct UserFoodEntity {
    
    let foodId: String
    let mealId: Int
    let weekDayId: Int
    let name: String
    var serving: Int
    let image: UIImage
    let calories: Double
    let proteins: Double
    let fats: Double
    let carbs: Double
    let fiber: Double
}
