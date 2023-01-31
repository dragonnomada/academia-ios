//: [Previous](@previous)

import Foundation
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubset(of: houseAnimals)
houseAnimals.isSubset(of: farmAnimals)
houseAnimals.isSubset(of: cityAnimals)

houseAnimals.isSuperset(of: houseAnimals)
houseAnimals.isSuperset(of: farmAnimals)
houseAnimals.isSuperset(of: cityAnimals)

houseAnimals.isDisjoint(with: houseAnimals)
houseAnimals.isDisjoint(with: farmAnimals)
houseAnimals.isDisjoint(with: cityAnimals)


//

farmAnimals.isSubset(of: houseAnimals)
farmAnimals.isSubset(of: farmAnimals)
farmAnimals.isSubset(of: cityAnimals)

farmAnimals.isSuperset(of: houseAnimals)
farmAnimals.isSuperset(of: farmAnimals)
farmAnimals.isSuperset(of: cityAnimals)

farmAnimals.isDisjoint(with: houseAnimals)
farmAnimals.isDisjoint(with: farmAnimals)
farmAnimals.isDisjoint(with: cityAnimals)


//
cityAnimals.isSubset(of: houseAnimals)
cityAnimals.isSubset(of: farmAnimals)
cityAnimals.isSubset(of: cityAnimals)

cityAnimals.isSuperset(of: houseAnimals)
cityAnimals.isSuperset(of: farmAnimals)
cityAnimals.isSuperset(of: cityAnimals)

cityAnimals.isDisjoint(with: houseAnimals)
cityAnimals.isDisjoint(with: farmAnimals)
cityAnimals.isDisjoint(with: cityAnimals)


