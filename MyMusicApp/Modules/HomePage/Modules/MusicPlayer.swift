//
//  MusicPlayer.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 15.06.2023.
//

import Foundation
import AVFoundation

class MusicPlayer {
    private var player: AVPlayer?
    private var currentURL: String?

    func playMusic(from url: String) {
        guard let musicURL = URL(string: url) else {
            print("Invalid music URL")
            return
        }

        if isPlayingMusic(from: url) {
            return
        }

        let playerItem = AVPlayerItem(url: musicURL)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
        currentURL = url
    }

    func stopMusic() {
        player?.pause()
        player = nil
        currentURL = nil
    }

    func isPlayingMusic(from url: String) -> Bool {
        return currentURL == url && player?.rate != 0 && player?.error == nil
    }
}
