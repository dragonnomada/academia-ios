//
//  SongPlayerViewController.swift
//  Musicapp
//
//  Created by MacBook on 18/01/23.
//

import UIKit

class SongPlayerViewController: UIViewController {

    weak var presenter: SongPlayerPresenter?
    
    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var albumLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeStartLabel: UILabel!
    
    @IBOutlet weak var timeEndLabel: UILabel!
    
    @IBOutlet weak var timeProgress: UIProgressView!
    
    @IBOutlet weak var lyricsTextView: UITextView!
    
    @IBOutlet weak var playButton: UIButton!
    
    var isReady = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.isReady = true
        self.presenter?.requestSongInfo()
        self.presenter?.requestSongIsPlaying()
    }
    
    @IBAction func togglePlayAction(_ sender: Any) {
        
        self.presenter?.togglePlay()
        
    }

}

extension Int {
    
    func twoDigits() -> String {
        return self <= 9 ? "0\(self)" : "\(self)"
    }
    
    func toTime() -> String {
        
        let minutes = self / 60
        let seconds = self % 60
        
        return "\(minutes.twoDigits()):\(seconds.twoDigits())"
        
    }
    
}

extension SongPlayerViewController: SongPlayerView {
    
    func player(isPlaying: Bool) {
        
        guard self.isReady else { return }
        
        if isPlaying {
            
            self.playButton.setImage(UIImage(systemName: "pause"), for: .normal)
            
        } else {
            
            self.playButton.setImage(UIImage(systemName: "play"), for: .normal)
        }
        
    }
    
    func player(currentTime time: Int, duration: Int, progress: Double) {
        
        guard self.isReady else { return }
        
        self.timeStartLabel.text = time.toTime()
        self.timeEndLabel.text = duration.toTime()
        self.timeProgress.progress = Float(progress)
        
    }
    
    func player(songInfo song: SongEntity) {
        
        guard self.isReady else { return }
        
        // TODO: Ajustar la canción
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
