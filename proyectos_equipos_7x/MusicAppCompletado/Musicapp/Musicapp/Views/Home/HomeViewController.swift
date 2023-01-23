//
//  HomeViewController.swift
//  Musicapp
//
//  Created by MacBook on 18/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    weak var presenter: SongsHomePresenter?
    
    // Enlace al CollectionView del HomeView.
    
    @IBOutlet weak var homeCollectionView: UICollectionView!

    var songs: [SongEntity] = []
    
    var songsInGender: [ SongGender : [SongEntity] ] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registramos la celda y la vista reusable al CollectionView.
        self.homeCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
        
        self.homeCollectionView.register(UINib(nibName: "HomeCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeCollectionReusableView")
        
        self.homeCollectionView.dataSource = self
        self.homeCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter?.requestSongs()
    }
    
    deinit {
        print("El presentador HomeViewController ha sido liberado")
    }
}

extension HomeViewController: HomeView {
    
    func player(songsFetched songs: [SongEntity]) {
        
        self.songs = songs
        
        self.songsInGender = [:]
        
        for song in songs {
            
            if var listOfSongsInGender = songsInGender[song.gender] {
                
                listOfSongsInGender.append(song)
                
                songsInGender[song.gender] = listOfSongsInGender
                
            } else {
                
                songsInGender[song.gender] = [song]
                
            }
            
        }
        
        self.homeCollectionView.reloadData()
        
    }
    
    func player(songsFetchedError error: SongsFetechedError) {
        
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        
        self.present(alert, animated: true)
        
    }
    
    func player(songsSelected song: SongEntity) {
        self.presenter?.goToSongInfo()
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return self.songsInGender.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var i = 0
        
        for gender in self.songsInGender.keys.sorted(by: { $0.rawValue < $1.rawValue }) {
            if section == i {
                
                if let listOfSongsInGender = self.songsInGender[gender] {
                    return listOfSongsInGender.count
                }
                
            }
            
            i += 1
        }
        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath)
        
        var i = 0
        
        for gender in self.songsInGender.keys.sorted(by: { $0.rawValue < $1.rawValue }) {
            if indexPath.section == i {
                
                if let listOfSongsInGender = self.songsInGender[gender] {
                    
                    let song = listOfSongsInGender[indexPath.row]
                    
                    if let cell = cell as? HomeCollectionViewCell {
                        
                        cell.setup(song: song)
                        
                    }
                    
                }
                
            }
            
            i += 1
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let reusable = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeCollectionReusableView", for: indexPath)
        
        var i = 0
        
        for gender in self.songsInGender.keys.sorted(by: { $0.rawValue < $1.rawValue }) {
            if indexPath.section == i {
                
                if let listOfSongsInGender = self.songsInGender[gender] {
                    
                    if let reusable = reusable as? HomeCollectionReusableView {
                        
                        reusable.setup(gender: gender, songsCount: listOfSongsInGender.count)
                        
                    }
                    
                }
                
            }
            
            i += 1
        }
        
        return reusable
        
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var i = 0
        
        for gender in self.songsInGender.keys.sorted(by: { $0.rawValue < $1.rawValue }) {
            if indexPath.section == i {
                
                if let listOfSongsInGender = self.songsInGender[gender] {
                    
                    let song = listOfSongsInGender[indexPath.row]
                    
                    self.presenter?.selectSong(song: song)
                    
                    //print(song)
                    
                }
                
            }
            
            i += 1
        }
        
    }
    
}
