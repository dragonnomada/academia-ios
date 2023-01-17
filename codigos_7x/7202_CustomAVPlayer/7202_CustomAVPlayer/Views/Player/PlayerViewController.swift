//
//  PlayerViewController.swift
//  7202_CustomAVPlayer
//
//  Created by Dragon on 17/01/23.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    var isAudioLoading: Bool = false
    var isPlaying: Bool = false
    var isShuffle: Bool = false
    var isRepeating: Bool = false
    var isLocked: Bool = false
    
    var duration: Int = 0
    var currentTime: Int = 0
    
    var playerItem: AVPlayerItem?
    var player: AVPlayer?
    var playerStatus: AVPlayer.Status = .unknown
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var timeProgressView: UIProgressView!
    
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var backwardButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    
    var shuffleLineView: UIView?
    var repeatDotView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createPlayer()
        
        self.loadPlayerItem()
        
        self.refreshPlayer()
    }
    
    func createPlayer() {
        
        self.player = AVPlayer()
        
        if let player = self.player {
            
            player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) {
                
                [weak self] _ in
                
                self?.refreshPlayer()
                
            }
            
            player.addObserver(self, forKeyPath: #keyPath(AVPlayer.status), options: [.old, .new], context: &self.playerStatus)
            
        }
        
    }
    
    func loadPlayerItem() {
        
        if let url = URL(string: "https://samplelib.com/lib/preview/mp3/sample-15s.mp3") {
            
            self.playerItem = AVPlayerItem(url: url)
            self.replacePlayerItem()
            
            /*let assetKeys = ["playable", "duration"]

            let asset = AVAsset(url: url)
            
            asset.loadValuesAsynchronously(forKeys: assetKeys, completionHandler: {
                
                DispatchQueue.main.async { [weak self] in
                    
                    self?.playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: assetKeys)
                    
                    self?.replacePlayerItem()
                    
                }
                
            })*/
            
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if context == &self.playerStatus {
            
            if let change = change {
                
                if let statusNumber = change[.newKey] as? NSNumber {
                    
                    let status = AVPlayer.Status(rawValue: statusNumber.intValue)
                    
                    if status == AVPlayer.Status.readyToPlay {
                        
                        self.isAudioLoading = true
                        self.refreshPlayer()
                        
                        /*DispatchQueue.main.async {
                            
                            if let player = self.player {
                                //player.isMuted = true
                                player.play()
                                
                                Thread.sleep(forTimeInterval: 4)
                                
                                player.pause()
                                //player.isMuted = false
                                player.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
                                
                                self.isAudioLoading = true
                                
                                self.refreshPlayer()
                            }
                            
                        }*/
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func replacePlayerItem() {
        
        if let player = self.player {
            if let playerItem = self.playerItem {
                
                player.replaceCurrentItem(with: playerItem)
                
            }
        }
        
    }
    
    func refreshPlayer() {
        
        if let player = self.player {
            
            if let currentItem = player.currentItem {
                self.currentTime = Int(player.currentTime().seconds)
                
                print(currentItem.duration.seconds)
                
                if currentItem.loadedTimeRanges.count >= 1 {
                    
                    for timeRange in currentItem.loadedTimeRanges {
                        
                        print("RANGE: \(timeRange.timeRangeValue.duration.seconds)")
                        
                    }
                    
                    let duration = currentItem.loadedTimeRanges[0].timeRangeValue.duration.seconds
                    
                    print("DURATION: \(duration)")
                    
                    if !duration.isNaN && !duration.isInfinite {
                        self.duration = Int(duration)
                    }
                    
                }
                
                /*if currentItem.duration.seconds.isInfinite || currentItem.duration.seconds.isNaN {
                    
                    if currentItem.asset.duration.seconds.isInfinite || currentItem.asset.duration.seconds.isNaN {
                    
                        self.duration = 0
                        
                    } else {
                        
                        self.duration = Int(currentItem.asset.duration.seconds)
                        
                    }
                    
                } else {
                    
                    self.duration = Int(currentItem.duration.seconds)
                    
                }*/
                
                
            }
            
        }
        
        if self.isAudioLoading {
            
            self.playButton.isEnabled = true
            
            if self.isPlaying {
                
                self.playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                
            } else {
                
                if self.currentTime > 5 {
                    self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                } else {
                    self.playButton.setImage(UIImage(systemName: "play"), for: .normal)
                }
                
            }
            
        } else {
            
            self.playButton.setImage(UIImage(systemName: "play.slash"), for: .disabled)
            self.playButton.isEnabled = false
            
        }
        
        if self.currentTime == 0 && self.duration == 0 {
            self.timeProgressView.progress = 0
        } else {
            self.timeProgressView.progress = Float(self.currentTime) / Float(self.duration)
        }
        
        let currentTimeInMinutes = Int(Double(self.currentTime) / 60.0)
        let currentTimeInSeconds = self.currentTime % 60
        
        self.currentTimeLabel.text = "\(currentTimeInMinutes):\(currentTimeInSeconds.fixed(digits: 2))"
        
        let durationInMinutes = Int(Double(self.duration) / 60.0)
        let durationInSeconds = self.duration % 60
        
        self.durationLabel.text = "\(durationInMinutes):\(durationInSeconds.fixed(digits: 2))"
        
        if self.isShuffle {
            
            //self.shuffleButton.layer.borderWidth = 1
            
            if let suffleLineView = self.shuffleLineView {
                
                self.shuffleButton.addSubview(suffleLineView)
                
            } else {
                
                let shuffleLineView = UIView(frame: CGRect(x: self.shuffleButton.frame.size.width / 4, y: self.shuffleButton.frame.size.height, width: self.shuffleButton.frame.size.width / 2, height: 2))
                
                shuffleLineView.backgroundColor = UIColor.systemBlue
                
                self.shuffleLineView = shuffleLineView
                
                self.shuffleButton.addSubview(shuffleLineView)
                
            }
            
        } else {
            
            //self.shuffleButton.layer.borderWidth = 0
            
            if let shuffleLineView = self.shuffleLineView {
                
                self.shuffleButton.willRemoveSubview(shuffleLineView)
                shuffleLineView.removeFromSuperview()
                
            }
            
        }
        
        if isRepeating {
            
            if let repeatDotView = self.repeatDotView {
                
                repeatButton.addSubview(repeatDotView)
                
            } else {
                
                let repeatDotView = UIView(frame: CGRect(x: self.repeatButton.frame.size.width / 2 - 2, y: self.repeatButton.frame.size.height - 2, width: 4, height: 4))
                
                repeatDotView.layer.cornerRadius = 2
                repeatDotView.backgroundColor = UIColor.systemPink
                
                self.repeatDotView = repeatDotView
                
                self.repeatButton.addSubview(repeatDotView)
                
            }
            
        } else {
            
            if let repeatDotView = self.repeatDotView {
                
                self.repeatButton.willRemoveSubview(repeatDotView)
                repeatDotView.removeFromSuperview()
                
            }
            
        }
        
    }
    
    @IBAction func toggleShuffleAction() {
        
        self.isShuffle = !self.isShuffle
        
        self.refreshPlayer()
        
    }
    
    @IBAction func backwardAction() {
        
        self.refreshPlayer()
        
    }
    
    @IBAction func togglePlayAction() {
        
        if let player = self.player {
            
            if self.isPlaying {
                
                player.pause()
                
            } else {
                
                player.play()
                
            }
            
        }
        
        self.isPlaying = !self.isPlaying
        
        self.refreshPlayer()
        
    }
    
    @IBAction func forwardAction() {
        
        self.refreshPlayer()
        
    }
    
    @IBAction func toggleRepeatAction() {
        
        self.isRepeating = !self.isRepeating
        
        self.refreshPlayer()
        
    }

}
