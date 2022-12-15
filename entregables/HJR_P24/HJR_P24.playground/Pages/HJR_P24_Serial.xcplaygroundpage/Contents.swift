/*
 Heber Eduardo Jimenez Rodriguez
 
 Creado el 15-12-22
 
 Practica 24 - Uso de concurrencia con GCD
 */

//Practica SERIAL

import UIKit

struct UserName: Decodable {
    let title: String
    let first: String
    let last: String
}

struct UserPicture: Decodable {
    let large: String
    let medium: String
    let thumbnail: String
}

struct UserDob: Decodable {
    let date: String
    let age: Int
}

struct User: Decodable {
    let gender: String
    let name: UserName
    let email: String
    let picture: UserPicture
    let nat: String
    let dob: UserDob
    
    var desc: String {
        "[\(nat) \(gender) \(dob.age) años] \(name.title) \(name.first) \(name.last) <\(email)>"
    }
}

struct ResponseInfo: Decodable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}

struct RandomUserResponse: Decodable {
    let results: [User]
    let info: ResponseInfo
}

// gender: male, female

enum UserGender: String {
    case male, female
}

// nat: AU, BR, CA, CH, DE, DK, ES, FI, FR, GB, IE, IN, IR, MX, NL, NO, NZ, RS, TR, UA, US

enum UserNat: String {
    case AU, BR, CA, CH, DE, DK, ES, FI, FR, GB, IE, IN, IR, MX, NL, NO, NZ, RS, TR, UA, US
}

func downloadUserCatalog(gender: UserGender, nat: UserNat, total: Int, completed: @escaping ([User]) -> Void) {
    guard let url = URL(string: "https://randomuser.me/api?gender=\(gender.rawValue)&nat=\(nat.rawValue)&inc=name,email,picture,nat,gender,dob&results=\(total)") else { return }

    let session = URLSession.shared.dataTask(with: url) {
        (data, response, error) in
        if let error = error {
            print(error)
        }
        if let data = data {
//            print(data)
            do {
                let response = try JSONDecoder().decode(RandomUserResponse.self, from: data)
//                print(response)
                completed(response.results)
            } catch {
                print("Error en la codificación JSON")
            }
        }
    }
    
    session.resume()
}

var serialDispatch = DispatchQueue(label: "Despachador serial")

//Calculando el promedio de 1000 mujeres MX SERIAL

print("ENCOLANDO PROMEDIO 1")
serialDispatch.async {
    print("---INICIO DE PROMEDIO DE MUJERES MX---")
    downloadUserCatalog(gender: .female, nat: .MX, total: 1000) {
        users in
        var promedio = 0.0
        users.forEach { user in
            promedio += Double(user.dob.age)/1000
        }
        print("El promedio de edad de las mujeres mx es: \(promedio)")
    }
    print("---FIN DE PROMEDIO DE MUJERES MX---")
}


//Calculando el promedio de 100 mujeres BR SERIAL

print("ENCOLANDO PROMEDIO 2")
serialDispatch.async {
    print("---INICIO DE PROMEDIO DE MUJERES BR---")
    downloadUserCatalog(gender: .female, nat: .BR, total: 100) {
        users in
        var promedio = 0.0
        users.forEach { user in
            promedio += Double(user.dob.age)/100
        }
        print("El promedio de edad de las mujeres br es: \(promedio)")
    }
    print("---FIN DE PROMEDIO DE MUJERES BR---")
}


//Calculando el promedio de 500 mujeres AU SERIAL

print("ENCOLANDO PROMEDIO 3")
serialDispatch.async {
    print("---INICIO DE PROMEDIO DE MUJERES MX---")
    downloadUserCatalog(gender: .female, nat: .AU, total: 500) {
        users in
        var promedio = 0.0
        users.forEach { user in
            promedio += Double(user.dob.age)/500
        }
        print("El promedio de edad de las mujeres au es: \(promedio)")
    }
    print("---FIN DE PROMEDIO DE MUJERES AU---")
}


//Calculando el promedio de 50 mujeres ch SERIAL

print("ENCOLANDO PROMEDIO 4")
serialDispatch.async {
    print("---INICIO DE PROMEDIO DE MUJERES CH---")
    downloadUserCatalog(gender: .female, nat: .CH, total: 50) {
        users in
        var promedio = 0.0
        users.forEach { user in
            promedio += Double(user.dob.age)/50
        }
        print("El promedio de edad de las mujeres ch es: \(promedio)")
    }
    print("---FIN DE PROMEDIO DE MUJERES CH---")
}

