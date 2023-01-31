import Foundation
//1
var players = ["Alice", "Bob", "Dan", "Eli", "Frank"]

//a
print(players.count)
//b
print(players.contains("Charles"))
//c
print(players.first!)
//d
print(players.last!)


//2
//a
players.insert("Charles", at: 2)
//b
players.append(contentsOf: ["Gloria","Hermione"])
print(players)
let teamOne = players[players.count-4...players.count-1]
print(teamOne)
