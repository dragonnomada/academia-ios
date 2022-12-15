/*
 Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
 15 de Diciembre de 2022
 Práctica 24 - Uso de concurrencia con GCD
 DispatchQueue Concurrent
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
//Llamada a la funcion descarga de catalogos de usuarios para 100 mujeres mexicanas
downloadUserCatalog(gender: .female, nat: .MX, total: 100) {
    users in
    users.forEach { user in print(user.desc) }
    // TODO: Calcular el promedio de edades
}
//Llamada a la funciòn descarga de catalogos de usuarios para 100 hombres mexicanos
downloadUserCatalog(gender: .male, nat: .MX, total: 100) {
    users in
    users.forEach { user in print(user.desc) }
    // TODO: Calcular el promedio de edades
}
 */
//Creaciòn de mi cocncurrentDispatch
var concurrentDispatch = DispatchQueue(label: "Despachador concurrente", attributes: .concurrent)
//Creaciòn de mi ConcurrentDispatch
concurrentDispatch.async {
    //Catalogo de mujeres Mèxico
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
//Invocacion de mi concurrentDispatch
concurrentDispatch.async {
    //Catalogo de Hombres Mèxico
    downloadUserCatalog(gender: .male, nat: .MX, total: 100) {
        users in
        var promedio = 0.0
        print("-----------------------------")
        print("Inicio Promedio Hombres Mèxico")
        users.forEach { user in  promedio += Double(user.dob.age)/100 }
        print("Promedio Hombres: \(promedio.rounded())")
        // TODO: Calcular el promedio de edades
        print("Fin Serial Promedio Hombres")
        print("\n")
        print("-----------------------------")
    }
    
}
//Invocaciòn ConcurrentDispatch
concurrentDispatch.async {
    //Catalogo de mujeres de estados unidos 
    downloadUserCatalog(gender: .female, nat: .US, total: 50) {
        users in
        var promedio = 0.0
        print("-----------------------------")
        print("Inicio Promedio Mujeres Estados Unidos")
        users.forEach { user in  promedio += Double(user.dob.age)/100 }
        print("Promedio Mujeres: \(promedio.rounded())")
        // TODO: Calcular el promedio de edades
        print("Fin Serial Promedio Mujeres")
        print("\n")
        print("-----------------------------")
    }
    
}
//Invocacion ConcurrentDispatch
concurrentDispatch.async {
    //
    downloadUserCatalog(gender: .male, nat: .US, total: 50) {
        users in
        var promedio = 0.0
        print("-----------------------------")
        print("Inicio Promedio Hombres Estados Unidos")
        users.forEach { user in  promedio += Double(user.dob.age)/100 }
        print("Promedio Hombres: \(promedio.rounded())")
        // TODO: Calcular el promedio de edades
        print("Fin Serial Promedio Hombres")
        print("\n")
        print("-----------------------------")
    }
    
}

