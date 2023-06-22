//
//  SongViewControllerProtocol.swift
//  MyMusicApp
//
//  Created by Евгений on 22.06.2023.
//

import UIKit

protocol SongViewControllerProtocol: AnyObject {
    func updateButtonImage(isPlay: Bool)
    func updateCurrentTimeLabel(duration: Int)
    func updateTotalDuration(duration: Float)
    func updateSlider(value: Float)
    func configurateView(model: Entry, image: UIImage)
    func setDurationTime()
}


