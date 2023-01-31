//
//  RecipeService.swift
//  MyCaloriAPP
//
//  Created by User on 23/01/23.
//

import Foundation
import Combine
import CoreData

class DietService {
    
    // Enums del DietService
    enum WeekDay: Int {
        
        case monday = 1
        case tuesday = 2
        case wednesday = 3
        case thursday = 4
        case friday = 5
        case saturday = 6
        case sunday = 7
    }
    
    enum Meal: Int {
        
        case breakfast = 1
        case lunch = 2
        case dinner = 3
    }
    
    enum DietServiceError: Error {
        
        case invalidWeekDayId
        case invalidMealId
        case coreDataLoadError
        case coreDataSaveError
        case addFoodError
        case removeFoodError
        case editServingsError
    }
    
    // Variables del DietService
    var userDiet: [UserFoodEntity]?
    var homeDiet: [UserFoodEntity]?
    var selectedWeekDayId: Int?
    var selectedMealId: Int?
    var weekDayMealDiet: [UserFoodEntity]?
    var selectedFood: UserFoodEntity?
    var apiSearchResult: [UserFoodEntity]?
    
    // Publicadores del DietService
    
    var selectWeekDaySubject = PassthroughSubject<(Int, DietServiceError), Never>()
    /*var selectWeekDaySubject = PassthroughSubject<(Int, DietServiceError), Never>()
    var selectWeekDaySubject = PassthroughSubject<(Int, DietServiceError), Never>()
    var selectWeekDaySubject = PassthroughSubject<(Int, DietServiceError), Never>()
    var selectWeekDaySubject = PassthroughSubject<(Int, DietServiceError), Never>()
    var selectWeekDaySubject = PassthroughSubject<(Int, DietServiceError), Never>()
    var selectWeekDaySubject = PassthroughSubject<(Int, DietServiceError), Never>()
    var selectWeekDaySubject = PassthroughSubject<(Int, DietServiceError), Never>()
    var selectWeekDaySubject = PassthroughSubject<(Int, DietServiceError), Never>()
    var selectWeekDaySubject = PassthroughSubject<(Int, DietServiceError), Never>()
    var selectWeekDaySubject = PassthroughSubject<(Int, DietServiceError), Never>()
    var selectWeekDaySubject = PassthroughSubject<(Int, DietServiceError), Never>()*/
    
    // Funcionalidad del DietService
    
    // Contenedor persistente del UserService
    
    private lazy var dietServiceContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MyCaloriAPP")
        
        container.loadPersistentStores {
            
            _, error in
            
            if let error = error {
                
                fatalError("[DietService] El contenedor persistente no pudo ser creado")
            } else {
                
                print("[DietService] El contenedor persistente se creó correctamente")
            }
        }
        
        return container
    }()
    
    // Actualiza el selectedWeekDayId según el día de la semana seleccionado
    func selectWeekDay(_ weekday: WeekDay) {
        
        self.selectedWeekDayId = weekday.rawValue
    }
    
    // Actualiza el selectedMealId según la comida seleccionada
    func selectMeal(_ meal: Meal) {
        
        self.selectedMealId = meal.rawValue
    }
    
    
    // Recupera el contexto de FoodEntity
    func loadCoreDataFood() {
        
        
    }
    
    // Recupera el contexto de FoodEntity, lo actualiza y lo guarda
    func saveCoreDataFood() {
        
        
    }
    
    // Recupera el contexto del FoodEntity, le agrega el selectedFood,
    // si ya existe le aumenta el serving por 1, guarda el contexto,
    // finalmente actualiza el userDiet e iguala el selectedFood a nil
    func addFood() {
        
        
    }
    
    // Recupera el contexto del FoodEntity, le remueve el selectedFood,
    // guarda el contexto, finalmente actualiza el userDiet e iguala el
    // selectedFood a nil
    func removeFood() {
        
        
    }
    
    // Recupera el contexto del FoodEntity, dado un selectedFood, actualiza
    // los servings, guarda el contexto, finalmente actualiza el userDiet e
    // iguala el selectedFood a nil
    func editServings() {
        
        
    }
    
    // Recupera el contexto de FoodEntity, en función de esta recupera
    // información del API y actualiza userDiet
    func requestApiInfoForUserDiet() {
        
        
    }
    
    // Consulta a la API dada una palabra clave como parámetro de búsqueda
    // y actualiza el apiSearchResult
    func requestApiFood(_ keyword: String) {
        
        
    }
    
    // Actualiza el selectedFood dado un UserFoodEntity
    func selectFood(_ selectedFood: UserFoodEntity) {
        
        self.selectedFood = selectedFood
    }
    
    // En función de la hora del día, utiliza el userDiet para actualizar
    // el homeDiet
    func refreshHomeDiet() {
        
        
    }
    
    // En función del día de la semana y la comida seleccionadas, utiliza
    // el userDiet para actualizar el weekDayMealDiet
    func refreshWeekDayMealDiet() {
        
        
    }
    
}
