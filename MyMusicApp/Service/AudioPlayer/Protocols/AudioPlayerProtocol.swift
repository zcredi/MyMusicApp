//
//  AudioPlayerProtocol.swift
//  MyMusicApp
//
//  Created by Евгений on 15.06.2023.
//

import Foundation

protocol AudioPlayerDelegate: AnyObject {
    func updateButtonImage(isPlay: Bool)
    func updateCurrentTimeLabel(duration: Int)
    func updateTotalDuration(duration: Float)
    func updateSlider(value: Float)
}
