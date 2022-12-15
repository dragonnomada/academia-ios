/*
 Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
 15 de Diciembre de 2022
 Práctica 24 - Uso de concurrencia con GCD
 DispatchQueue Serial
*/

import UIKit
//Creaciòn de la estructura Username
struct UserName: Decodable {
    let title: String
    let first: String
    let last: String
}
//Creaciòn de la estructura UserPicture
struct UserPicture: Decodable {
    let large: String
    let medium: String
    let thumbnail: String
}
//Creaciòn de la estructura UserDob
struct UserDob: Decodable {
    let date: String
    let age: Int
}
//Creaciòn de la estructura User
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
//Creaciòn de la estructura ResponseInfo
struct ResponseInfo: Decodable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}
//Creaciòn de la estructura RandomUser
struct RandomUserResponse: Decodable {
    let results: [User]
    let info: ResponseInfo
}

// gender: male, female
//Creaciòn del enumerable para los generos
enum UserGender: String {
    case male, female
}

// nat: AU, BR, CA, CH, DE, DK, ES, FI, FR, GB, IE, IN, IR, MX, NL, NO, NZ, RS, TR, UA, US
//Creaciòn de el enumerable para cada nacionalidad
enum UserNat: String {
    case AU, BR, CA, CH, DE, DK, ES, FI, FR, GB, IE, IN, IR, MX, NL, NO, NZ, RS, TR, UA, US
}
//Funciòn encargada de hacer la conexion al API y crear sesiòn para matchear los datos
func downloadUserCatalog(gender: UserGender, nat: UserNat, total: Int, completed: @escaping ([User]) -> Void) {
    //Se asegura que se haga la conexion a la url
    guard let url = URL(string: "https://randomuser.me/api?gender=\(gender.rawValue)&nat=\(nat.rawValue)&inc=name,email,picture,nat,gender,dob&results=\(total)") else { return }
    //Se crea la sesion
    let session = URLSession.shared.dataTask(with: url) {
        (data, response, error) in
        if let error = error {
            print(error)
        }//se parsea la data
        if let data = data {
//            print(data)
            do {//Se decodifica la respuesta json
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
/*
downloadUserCatalog(gender: .female, nat: .US, total: 50) {
    users in
    var promedio = 0.0
    users.forEach { user in  promedio += Double(user.dob.age)/50 }
    // TODO: Calcular el promedio de edades
}
downloadUserCatalog(gender: .male, nat: .US, total: 50) {
    users in
    var promedio = 0.0
    users.forEach { user in  promedio += Double(user.dob.age)/50 }
    // TODO: Calcular el promedio de edades
}
 */

//Creaciòn de mi serialDispatch
var serialDispatch = DispatchQueue(label: "Despachador serial")
//Invocacion de mi serial Dispatch
serialDispatch.async {
    //Catalogo de Mujeres Estados Unidos
    downloadUserCatalog(gender: .female, nat: .US, total: 50) {
        users in
        var promedio = 0.0
        print("-----------------------------")
        print("Inicio Promedio Mujeres Estados Unidos")
        users.forEach { user in  promedio += Double(user.dob.age)/50 }
        print("Promedio Mujeres: \(promedio.rounded())")
        // TODO: Calcular el promedio de edades
        print("Fin Serial Promedio Mujeres")
        print("\n")
        print("-----------------------------")
    }
}
serialDispatch.async {
    //Catalogo de hombres estados unidos
    downloadUserCatalog(gender: .male, nat: .US, total: 50) {
        users in
        var promedio = 0.0
        print("-----------------------------")
        print("Inicio promedio Hombres Estados Unidos")
        users.forEach { user in  promedio += Double(user.dob.age)/50 }
        print("Promedio Hombres: \(promedio.rounded())")
        // TODO: Calcular el promedio de edades
        print("Fin Serial Promedio Hombres")
        print("\n")
        print("-----------------------------")
    }
}

serialDispatch.async {
    //Catalogo de Mujeres Mèxico
    downloadUserCatalog(gender: .female, nat: .MX, total: 100) {
        users in
        var promedio = 0.0
        print("-----------------------------")
        print("Inicio Promedio Mujeres Mèxico")
        users.forEach { user in  promedio += Double(user.dob.age)/100 }
        print("Promedio Mujeres: \(promedio.rounded())")
        // TODO: Calcular el promedio de edades
        print("Fin Serial Promedio Mujeres")
        print("\n")
        print("-----------------------------")
    }
}
serialDispatch.async {
    //Catalogo de hombres Mèxico
    downloadUserCatalog(gender: .male, nat: .US, total: 100) {
        users in
        var promedio = 0.0
        print("-----------------------------")
        print("Inicio promedio Hombres Mèxico")
        users.forEach { user in  promedio += Double(user.dob.age)/100 }
        print("Promedio Hombres: \(promedio.rounded())")
        // TODO: Calcular el promedio de edades
        print("Fin Serial Promedio Hombres")
        print("\n")
        print("-----------------------------")
    }
}
