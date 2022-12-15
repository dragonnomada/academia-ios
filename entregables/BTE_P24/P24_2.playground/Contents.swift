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
    let dispatchGroup = DispatchGroup()
    
    dispatchGroup.enter()
    
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
        dispatchGroup.leave()
    }
    
    session.resume()
}




// Serial

var serialDispatch = DispatchQueue(label: "Despachador concurrente", attributes: .concurrent)

serialDispatch.async {
    
    
    // PROMEDIO MUJERES MX 100
    
    downloadUserCatalog(gender: .female, nat: .MX, total: 100) {
        
        users in
        
        var promedio = 0.0
        print("INICIO DE PROMEDIOS DE 100 MUJERES DE MX ")
        users.forEach { user in
            promedio += Double(user.dob.age) / 100.0
            //print(".",terminator: "")
        }
        //print("")
        print("TOTAL PROMEDIO DE 100 MUJERES DE MX \(promedio.rounded())")
        print("FIN DE PROMEDIOS DE 100 MUJERES DE MX ")
        print("----------------------------------------")

    }
}

serialDispatch.async {
    // PROMEDIO HOMBRES MX 100
    downloadUserCatalog(gender: .male, nat: .MX, total: 100) {
        
        users in
        
        var promedio = 0.0
        print("INICIO DE PROMEDIOS DE 100 HOMBRES DE MX ")
        users.forEach { user in
            promedio += Double(user.dob.age) / 100.0
        }
        //print("")
        print("TOTAL PROMEDIO DE 100 HOMBRES DE MX \(promedio.rounded())")
        print("FIN DE PROMEDIOS DE 100 HOMBRES DE MX ")
        print("----------------------------------------")
    }

}


serialDispatch.async {
    
    // PROMEDIO MUJERES EU 100
    downloadUserCatalog(gender: .female, nat: .US, total: 100) {
        users in
        var promedio = 0.0
        print("INICIO DE PROMEDIOS DE 100 MUJERES DE EU ")
        users.forEach { user in
            promedio += Double(user.dob.age) / 100.0
            //print(".",terminator: "")
        
        }
        //print("")
        print("TOTAL PROMEDIO DE 100 MUJERES DE EU \(promedio.rounded())")
        print("FIN DE PROMEDIOS DE 100 MUJERES DE EU ")
        print("----------------------------------------")

    }
        
}

serialDispatch.async {
    
    // PROMEDIO MUJERES EU 50
    downloadUserCatalog(gender: .male, nat: .US, total: 100) {
        users in
        var promedio = 0.0
        
        print("INICIO DE PROMEDIOS DE 100 HOMBRES DE EU ")
        users.forEach { user in
            promedio += Double(user.dob.age) / 100.0
            //print(".",terminator: "")
        
        }
        print("")
        print("TOTAL PROMEDIO DE 100 HOMBRES DE EU \(promedio.rounded())")
        print("FIN DE PROMEDIOS DE 100 HOMBRES DE EU ")
        print("----------------------------------------")

    }
}

