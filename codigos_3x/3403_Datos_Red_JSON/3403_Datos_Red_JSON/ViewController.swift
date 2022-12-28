//
//  ViewController.swift
//  3403_Datos_Red_JSON
//
//  Created by User on 22/12/22.
//

import UIKit

struct People: Decodable {
    let name: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let vehicles: [String]
    let starships: [String]
    let created: String
    let edited: String
    let url: String
}

struct PeopleResponse: Decodable {
    let count: Int
    let next: String
    let previous: String?
    let results: [People]
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var people: [People] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchPeople()
    }
    
    func fetchPeople() {
        
        guard let url = URL(string: "https://swapi.dev/api/people") else { return }

        print("Solicitando API")
        
        let session = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            print("El API ha respondido")
            
            if let error = error {
                print("Error al consumir el api \(url). Error: \(error)")
                return
            }
            
            if let data = data {
                if let text = String(data: data, encoding: .utf8) {
                    print("EL texto es: \(text)")
                }
                if let peopleResponse = try? JSONDecoder().decode(PeopleResponse.self, from: data) {
                    print(peopleResponse)
                    self.people = peopleResponse.results
                    // TODO: Actualizar la tabla
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
//                do {
//                    try JSONDecoder().decode(PeopleResponse.self, from: data)
//                } catch {
//                    print("Error \(error)")
//                }
            }
        }
        
        print("Enviando la petición a la sesión del API")
        session.resume()
        
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Personajes de Star Wars"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleCell")!
        
        let person = people[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        
        config.text = person.name
        config.secondaryText = "\(person.gender)"
        
        cell.contentConfiguration = config
        
        return cell
    }
    
}

