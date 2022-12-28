/*
 Heber Eduardo Jimenez Rodriguez
 
 Creado el 27-12-22
 
 Proyecto: TutoriApp
*/

// VideosCell = celda reutilizable


import UIKit
import AVFoundation
import AVKit

class VideosViewController: UIViewController {
    
    
    @IBOutlet weak var videosTableView: UITableView!
    
    var videos: [VideoResponse] = [VideoResponse(url: "https://www.pexels.com/es-es/video/8927748/download/", title: "¿Cómo girar una flor?", duration: 15),
                                   VideoResponse(url: "https://www.pexels.com/es-es/video/8035714/download/", title: "¿Cómo prender una luz?", duration: 89),
                                   VideoResponse(url: "https://www.pexels.com/es-es/video/9871249/download/", title: "¿Cómo caminar con tu pareja?", duration: 72)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        fetchVideo()
        
        videosTableView.delegate = self
        videosTableView.dataSource = self
    }
    
    // Funcion que nos brindara los datos desde una api
    @IBAction func playVideo(_ sender: Any) {
        
        //guard let url = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4") else { return }
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
                if let text = String(data: data, encoding: .utf8) {
                    print(text)
                }
                if let videoResponse = try? JSONDecoder().decode(VideoResponse.self, from: data) {
                    print(videoResponse)
                    videos.append(videoResponse)
                    
                    // TODO: Actualizar la tabla
                    DispatchQueue.main.async {
                        //self.tableView.reloadData()
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

extension VideosViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Numero de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Titulo de la seccion
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
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


// Estructura que retendra ls datos que nos devuelva la api.
struct VideoResponse: Decodable {
    var url: String
    var title: String
    var duration: Int
}



/*
 {
       "title":"¿Cómo girar una flor?",
       "duration":105,
       "url":"https://www.pexels.com/es-es/video/8927748/download/"
    }
 */
