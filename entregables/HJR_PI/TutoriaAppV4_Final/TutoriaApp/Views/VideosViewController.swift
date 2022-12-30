
// Heber Eduardo Jimenez Rodriguez
//
// Creado el 27-12-22
//
// Proyecto: TutoriApp
//

// VideosCell = celda reutilizable


import UIKit
// Se importa AVFoundation y AVKit para poder reproducir videos en nuestra app
import AVFoundation
import AVKit

// Estructura que retendra los datos que nos devuelva la api.
struct Video: Decodable {
    var url: String
    var title: String
    var duration: Int
}

struct VideoResponse: Decodable {
    var results: [Video]
}

class VideosViewController: UIViewController {
    
    @IBOutlet weak var videosTableView: UITableView!
    
    // Variable de tipo array, que contendra todos los tutoriales que nos devuelva el api
    var videos: [Video] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuración del color de la pagina
        view.backgroundColor = .orange
        
        // Asignamos quien sera nuestro delegate y nuestro dataSource
        videosTableView.delegate = self
        videosTableView.dataSource = self
        
        // Ejecutamos la funcion que consultara a la api
        fetchVideo()
    }
    
    // Funcion para consultar una api, para que nos brinde los datos que solicitamos.
    func fetchVideo() {
        
        // Indicamos cual sera la url a donde consultaremos la api
        guard let url = URL(string: "http://34.125.242.89/api/tutoriapp/videos") else { return }
        print("Solicitando API")
        
        // Inicio de sesion a la url dada
        let session = URLSession.shared.dataTask(with: url) { [self]
            (data, response, error) in
            
            print("El API ha respondido")
            
            // Manejo de error en caso de obtener un error a la hora de iniciar sesion a la api
            if let error = error {
                print("Error al consumir el api \(url). Error: \(error)")
                return
               }
            // Si logra obtener data, la recuperamos en "data"
            if let data = data {
                // Imprimir la data en consola
                if let text = String(data: data, encoding: .utf8) {
                    print(text)
                }
                // La api no nos regresa los results por eso lo convertimos a "Array<Video>"
                if let videoResponse = try? JSONDecoder().decode(Array<Video>.self, from: data) {
                    print(videoResponse)
                    videos = videoResponse
                    print(videos.count)
                    // Actualizacion de la tabla
                    DispatchQueue.main.async {
                        self.videosTableView.reloadData()
                    }
                }
            }
        }
        print("Enviando la petición a la sesión del API")
        session.resume()
    }
}


// Extencion de "VideosViewController" para poder implementar UITableViewDelegate, UITableViewDataSource
extension VideosViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Numero de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        //return videos.count
    }
    
    // Titulo de la seccion
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return videos[section].title
        return "Tutotiales"
    }
    
    // DataSource, donde vemos el contenido del arreglo
    // Numero de filas de la seccion
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Segun el numero de elementos existentes en ekl arreglo "videos", sera el numero de filas
        return videos.count
    }
    
    // Configuracion de la celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Recupera la celda
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideosCell")!
        let video = videos[indexPath.row]
        // Configuración de la celda
        var config = cell.defaultContentConfiguration()
        config.text = "Titulo: " + video.title
        config.secondaryText = "Duracion: \(video.duration)"
        cell.contentConfiguration = config
        // Regresa la celda configurada
        return cell
        }
    
    // Funcion para poder reproducir los videos apartir de una url
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Configuramos la url de cada tutorial
        guard let url = URL(string: "\(videos[indexPath.row].url)") else { return }
        
        // Cree un AVPlayer, pasándole la URL HTTP Live Streaming.
        let player = AVPlayer(url: url)
        
        // Crear un nuevo AVPlayerViewController y pasarle una referencia al jugador.
        let controller = AVPlayerViewController()
        controller.player = player
        
        // Presentar modalmente al jugador y llamar al método play() del jugador cuando se complete.
        present(controller, animated: true) {
            player.play()
        }
    }
}
