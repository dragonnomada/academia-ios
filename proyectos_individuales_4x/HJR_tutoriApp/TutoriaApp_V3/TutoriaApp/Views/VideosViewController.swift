/*
 Heber Eduardo Jimenez Rodriguez
 
 Creado el 27-12-22
 
 Proyecto: TutoriApp
*/

// VideosCell = celda reutilizable


import UIKit
import AVFoundation
import AVKit

// Estructura que retendra ls datos que nos devuelva la api.
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
    
    var videos: [Video] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        
        videosTableView.delegate = self
        videosTableView.dataSource = self
        
        fetchVideo()
    }
    
    // Funcion para consultar una api, para que nos brinde los datos que solicitamos.
    func fetchVideo() {
        
        guard let url = URL(string: "http://34.125.242.89/api/tutoriapp/videos") else { return }
        print("Solicitando API")
        
        let session = URLSession.shared.dataTask(with: url) { [self]
            (data, response, error) in
            
            print("El API ha respondido")
            
            if let error = error {
                print("Error al consumir el api \(url). Error: \(error)")
                return
               }
            
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
                    // TODO: Actualizar la tabla
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

extension VideosViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Numero de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        return videos.count
    }
    
    // Titulo de la seccion
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return videos[section].title
    }
    
    // DataSource, donde vemos el contenido del arrego
    // Numero de filas de la seccion
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    // Configuracion de la celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Recupera la celda
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideosCell")!
        let video = videos[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = "Titulo: " + video.title
        config.secondaryText = "Duracion: \(video.duration)"
        cell.contentConfiguration = config
        
        return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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

/*
 @IBAction func playVideo(_ sender: Any) {
     
     guard let url = URL(string: "https://www.pexels.com/es-es/video/8927748/download/") else { return }
     
     // Cree un AVPlayer, pasándole la URL HTTP.
     let player = AVPlayer(url: url)
     
     // Crear un nuevo AVPlayerViewController y pasarle una referencia al player.
     let controller = AVPlayerViewController()
     controller.player = player
     
     // Presentar modalmente al jugador y llamar al método play() del player cuando se complete.
     present(controller, animated: true) {
         player.play()
     }
     
 }
 */
/*
 {
       "title":"¿Cómo girar una flor?",
       "duration":105,
       "url":"https://www.pexels.com/es-es/video/8927748/download/"
    }
 */
