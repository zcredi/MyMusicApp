//
//  AudioPlayer.swift
//  MyMusicApp
//
//  Created by Евгений on 15.06.2023.
//

import UIKit
import AVFoundation

final class AudioPlayer {
    
    static let instance = AudioPlayer()
    weak var delegate: AudioPlayerDelegate?
    
    private var player: AVPlayer?
    
    private var audioTracks: [String] = [
        "metallica_-_nothing-else-matters", "Murray One night in Bangkoc", "Rammstein Feuer frei"
    ]
    private var numberOfTrack = 0
    
    
    private init() {
        configurePlayer(track: audioTracks[numberOfTrack])
    }
    
    func configurePlayer(track: String) {
        if let path = Bundle.main.path(forResource: track, ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            let playerItem = AVPlayerItem(url: url)
            
            player = AVPlayer(playerItem: playerItem)
        }
    }
    
    // Managing Player:
    func startPlayer() {
        guard let player = player else { return }
        
        delegate?.updateButtonImage(isPlay: true)
        player.play()
        updatePlayerValues()
    }
    
    func pausePlayer() {
        guard let player = player else { return }
        
        delegate?.updateButtonImage(isPlay: false)
        player.pause()
    }
    
    func isPlayerPlaying() -> Bool {
        guard let player = player else { return false }
        
        return player.timeControlStatus == .playing ? true : false
    }
    
    // Managing track:
    func rewindTrack(at time: Float) {
        player?.seek(to: CMTime(seconds: Double(time), preferredTimescale: 1000))
    }
    
    func nextTrack() {
        if audioTracks.count - 1 == numberOfTrack {
            numberOfTrack = 0
        } else {
            numberOfTrack += 1
        }
        
        configurePlayer(track: audioTracks[numberOfTrack])
        startPlayer()
        updatePlayerValues()
    }
    
    func previousTrack() {
        if numberOfTrack > 0 {
            numberOfTrack -= 1
            updatePlayerValues()
        } else {
            configurePlayer(track: audioTracks[numberOfTrack])
            startPlayer()
            updatePlayerValues()
        }
    }
    
    func getTrackDuration() -> Double {
        guard let duration = player?.currentItem?.asset.duration else { return 0 }
        
        return duration.seconds
    }
    
    func updatePlayerValues() {
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 60),
                                        queue: DispatchQueue.main) { [weak self] CMTime in
            guard let self = self else { return }
            delegate?.updateSlider(value: Float(CMTime.seconds))
            delegate?.updateCurrentTimeLabel(duration: Int(CMTime.seconds))
        }
    }
}
