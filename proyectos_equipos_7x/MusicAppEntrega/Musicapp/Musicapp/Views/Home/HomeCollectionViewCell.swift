//
//  HomeCollectionViewCell.swift
//  Musicapp
//
//  Created and Mantained by Brian Jiménez Moedano on 18/01/23.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    // Enlace al imageView de la CollectionViewCell.
    @IBOutlet weak var songImage: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setup(song: SongEntity) {
        
        titleLabel.text = song.title
        artistLabel.text = song.artist
        
        Task {
            
            if let url = URL(string: song.pictureUrl) {
                
                if let (data, _) = try? await URLSession.shared.data(for: URLRequest(url: url)) {
                    
                    self.songImage.image = UIImage(data: data)
                    
                }
                
            }
            
        }
        
    }

}
