//
//  SongInfoViewController.swift
//  Musicapp
//
//  Created by MacBook on 18/01/23.
//

import UIKit

class SongInfoViewController: UIViewController {

    weak var presenter: SongInfoPresenter?
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var lyricsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Se ha cargado SongInfoViewController")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(self.presenter != nil ? "CON PRESENTER" : "SIN PRESENTER")
        self.presenter?.requestSongInfo()
    }
    
    @IBAction func playAction() {
        
        self.presenter?.play()
        
    }

}

extension SongInfoViewController: SongInfoView {
    
    func player(songsPlayed song: SongEntity) {
        
        self.presenter?.goToPlayer()
        
    }
    
    func player(songsSelected song: SongEntity) {
        
        print("Canción seleccionada: \(song.title)")
        
        self.titleLabel.text = song.title
        self.artistLabel.text = song.artist
        self.albumLabel.text = song.album
        self.lyricsTextView.text = song.lyrics
        
        Task {
            
            if let url = URL(string: song.pictureUrl) {
                
                if let (data, _) = try? await URLSession.shared.data(for: URLRequest(url: url)) {
                    
                    self.pictureImageView.image = UIImage(data: data)
                    
                }
                
            }
            
        }
        
    }
    
}
