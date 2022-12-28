//
//  ViewController.swift
//  4302_sigues_envio_Datos
//
//  Created by MacBook  on 28/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frutasTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        frutasTableView.dataSource = self
        frutasTableView.delegate = self
    }


}

extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Frutas"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FrutasRepository.shared.getFrutasCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")!
        
        // TODO: configurar la celda
        
        if let fruta = FrutasRepository.shared.getFrutas(index: indexPath.row){
            var confing = cell.defaultContentConfiguration()
            
            confing.text = fruta.nombre
            confing.secondaryText = "\(fruta.peso) kg"
            
            cell.contentConfiguration = confing
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    
    // cada que seleccione una celda, me va a decir en que indice esta
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("\(indexPath.section) en la fila \(indexPath.row)")
        
        if let fruta = FrutasRepository.shared.getFrutas(index: indexPath.row){
            print(fruta)
            // le mandamos un objeto en este caso la fruta podemos mandar una tupla
            self.performSegue(withIdentifier: "AtoB", sender: fruta)
        }
        
    }
    
    
}

extension ViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ///** PASO 3 configuramos la fruta de la pnatalla b desde la pantalla
        ///
        ///1 recuperamos la pantalla b
        if let pantallaB = segue.destination as? BViewController{
            /// 2 reconvertimos el sender como fruta (lo que se envio en el performSigue)
            if let fruta = sender as? Fruta{
                
                // ajuntar o configurar la fruta opcional de la pantalla B
                pantallaB.fruta = fruta
            }
        }
        
    }
}

