//: [Previous](@previous)

import Foundation

var mythicalPets : Set<String> = [
    "🦉 Owl",
    "🛄 Luggage",
    "🔨 Hammer",
    "🐉 Toothless",
    "☁️ Flying Nimbus"
]

var animalPets = Set<String>()

animalPets.insert("🥭 Mango")
animalPets.insert("🐯 Tiger")
animalPets.insert("🐉 Toothless")
animalPets.insert("🦉 Owl")

// 1
print("----------UNION-------------")
print(mythicalPets.union(animalPets))
print("*--------------------------*\n")
// 2
print("-----INTERSECTION-----------")
print(mythicalPets.intersection(animalPets))
print("*--------------------------*\n")

// 3
print("---------REMOVE-------------")
print(animalPets)
if let removedPet = animalPets.remove("🥭 Mango") {
    print("\(removedPet) Eliminado.")
} else {
    print("nil")
}
print(animalPets)
print("*--------------------------*\n")

//: [Next](@next)
