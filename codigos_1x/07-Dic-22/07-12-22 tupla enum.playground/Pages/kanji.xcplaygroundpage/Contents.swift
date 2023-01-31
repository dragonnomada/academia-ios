//: [Previous](@previous)

import Foundation
// 4x4

var matrizCaracteres = [[Character]](repeating: [Character](repeating:" ", count: 4), count: 4)

//print(matrizCaracteres)
let entrada = "Hello World".map { character in
    return character
}

var index = 0
for i in stride(from: 2, through: 0, by: -1){
    for j in stride(from: 0, through: 3, by: 1){
        if index < entrada.count {
            matrizCaracteres[i][j] = entrada[index]
            index+=1
        }
    }
}

for i in stride(from: 0, to:4, by: 1){
    for j in stride(from: 0, to: 4, by: 1){
     print(matrizCaracteres[j][i],terminator: "")
    }
    print("")
}


//: [Next](@next)
