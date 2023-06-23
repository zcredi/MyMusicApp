//
//  SongViewControllers.swift
//  MyMusicApp
//
//  Created by Евгений on 13.06.2023.
//

import UIKit
import SnapKit
import SwiftUI

final class SongViewController: UIViewController, SongViewControllerProtocol {
    
    weak var favoriteVC: FavoritesViewControllerProtocol?
    
    private var songView = SongView()
    private let musicPlayer = MusicPlayer.instance
    private var currentTrackModel: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicPlayer.songController = self
        view.backgroundColor = .brandBlack
        
        setDurationTime()
        setViews()
        setConstraints()
        setTargets()
        updateButtonImage(isPlay: false)
    }
    
    func configureCell(with musicResult: Entry) {
        currentTrackModel = musicResult
        
        songView.songNameLabel.text = musicResult.name.label
        songView.performerNameLabel.text = musicResult.artist.label
        
        if let imageUrlString = musicResult.images.first?.label,
           let imageUrl = URL(string: imageUrlString) {
            songView.songImageView.kf.setImage(with: imageUrl)
        } else {
            songView.songImageView.image = nil
        }
        
        guard let favoriteVC = favoriteVC, let currentTrackModel = currentTrackModel else { return }
        
        if favoriteVC.isCurrentSongFavorite(selectedSong: currentTrackModel) {
            songView.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            songView.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    private func setTargets() {
        songView.backHomeButton.addTarget(self, action: #selector(backHome), for: .touchUpInside)
        songView.likeButton.addTarget(self, action: #selector(changeStatusLikeButton), for: .touchUpInside)
        songView.sliderView.addTarget(self, action: #selector(rewindTrack), for: [.touchUpInside])
        songView.playButton.addTarget(self, action: #selector(controlPlayer), for: .touchUpInside)
        songView.nextTrackButton.addTarget(self, action: #selector(nextTrack), for: .touchUpInside)
        songView.previousTrackButton.addTarget(self, action: #selector(previousTrack), for: .touchUpInside)
    }
    
    private func convertSecondsToMinutes(_ totalSeconds: Float) -> Float {
        let minute = Float(Int(totalSeconds) / 60)
        let seconds = Float(Int(totalSeconds) % 60)
        
        return Float(minute + (seconds / 100))
    }
    
    private func addToFavoriteMusic() {
        guard let currentTrackModel = currentTrackModel else { return }
        favoriteVC?.appendFavoriteSong(currentTrackModel)
    }
    
    private func removeFromFavoriteMusic() {
        guard let currentTrackModel = currentTrackModel, let favoriteVC = favoriteVC else { return }
        
        if favoriteVC.isCurrentSongFavorite(selectedSong: currentTrackModel) {
            favoriteVC.removeSongFromFavorites(selectedSong: currentTrackModel)
        }
    }
    
    @objc private func backHome() {
        dismiss(animated: true)
    }
    
    @objc func changeStatusLikeButton() {
        favoriteVC?.songViewController = self
        if songView.likeButton.imageView?.image == UIImage(systemName: "heart") {
            addToFavoriteMusic()
            songView.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            songView.likeButton.tintColor = .brandGreen
        } else {
            removeFromFavoriteMusic()
            songView.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            songView.likeButton.tintColor = .neutralWhite
        }
    }
    
    @objc private func controlPlayer() {
        musicPlayer.isPlayerPerforming() ? musicPlayer.pauseMusic() : musicPlayer.playMusic()
    }
    
    @objc private func rewindTrack() {
        musicPlayer.rewindTrack(at: songView.sliderView.value)
        musicPlayer.playMusic()
    }
    
    @objc private func nextTrack() {
        musicPlayer.playNextSong()
        
        let duration = musicPlayer.getTrackDuration()
        songView.rightSliderLabel.text = "\(convertSecondsToMinutes(Float(duration)))"
        songView.sliderView.maximumValue = Float(duration)
    }
    
    @objc private func previousTrack() {
        musicPlayer.playPreviousSong()
        
        let duration = musicPlayer.getTrackDuration()
        songView.rightSliderLabel.text = "\(convertSecondsToMinutes(Float(duration)))"
        songView.sliderView.maximumValue = Float(duration)
    }
    
    func reloadLikeButton() {
        guard let favoriteVC = favoriteVC, let currentTrackModel = currentTrackModel else { return }
        
        if !favoriteVC.isCurrentSongFavorite(selectedSong: currentTrackModel) {
            songView.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func setDurationTime() {
        let duration = musicPlayer.getTrackDuration()
        
        songView.rightSliderLabel.text = "\(convertSecondsToMinutes(Float(duration)))"
        songView.sliderView.maximumValue = Float(Int(duration))
    }
    
    func updateButtonImage(isPlay: Bool) {
        let image = isPlay ? UIImage(systemName: "pause.fill") : UIImage(systemName: "play")
        
        songView.playButton.setImage(image, for: .normal)
    }
    
    func updateCurrentTimeLabel(duration: Int) {
        songView.leftSliderLabel.text = "\(convertSecondsToMinutes(Float(duration)))"
    }
    
    func updateTotalDuration(duration: Float) {
        songView.sliderView.maximumValue = convertSecondsToMinutes(duration)
    }
    
    func updateSlider(value: Float) {
        let newValue = value / songView.sliderView.maximumValue
        
        songView.sliderView.value = songView.sliderView.maximumValue * newValue
    }
}

// Setup views:
extension SongViewController {
    private func setViews() {
        view.addSubview(songView.backHomeButton)
        view.addSubview(songView.songPageControl)
        view.addSubview(songView.songImageView)
        view.addSubview(songView.songNameLabel)
        view.addSubview(songView.performerNameLabel)
        view.addSubview(songView.describingSongLabel)
        view.addSubview(songView.topButtonsStackView)
        
        songView.topButtonsStackView.addArrangedSubview(songView.shareButton)
        songView.topButtonsStackView.addArrangedSubview(songView.addToAlbomButton)
        songView.topButtonsStackView.addArrangedSubview(songView.likeButton)
        songView.topButtonsStackView.addArrangedSubview(songView.downloadButton)
        
        view.addSubview(songView.sliderView)
        view.addSubview(songView.leftSliderLabel)
        view.addSubview(songView.rightSliderLabel)
        
        view.addSubview(songView.shuffleButton)
        view.addSubview(songView.previousTrackButton)
        view.addSubview(songView.playButton)
        view.addSubview(songView.nextTrackButton)
        view.addSubview(songView.repeatButton)
        view.addSubview(songView.previousTrackButton)
        view.addSubview(songView.shuffleButton)
        view.addSubview(songView.nextTrackButton)
        view.addSubview(songView.repeatButton)
    }
}

// Setup views constraints:
extension SongViewController {
    private func setConstraints() {
        songView.backHomeButton.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.top.equalToSuperview().inset(64)
            make.leading.equalToSuperview().inset(30)
        }
        
        songView.songPageControl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
        }
        
        songView.songImageView.snp.makeConstraints { make in
            make.width.height.equalTo(207)
            make.top.equalTo(songView.songPageControl.snp.bottom).inset(-52)
            make.centerX.equalToSuperview()
        }
        
        songView.songNameLabel.snp.makeConstraints { make in
            make.top.equalTo(songView.songImageView.snp.bottom).inset(-22)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        songView.performerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(songView.songNameLabel.snp.bottom).inset(-4)
            make.centerX.equalToSuperview()
        }
        
        songView.describingSongLabel.snp.makeConstraints { make in
            make.top.equalTo(songView.performerNameLabel.snp.bottom).inset(-22)
            make.centerX.equalToSuperview()
        }
        
        songView.topButtonsStackView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(songView.describingSongLabel.snp.bottom).inset(-50)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        songView.sliderView.snp.makeConstraints { make in
            make.top.equalTo(songView.topButtonsStackView.snp.bottom).inset(-30)
            make.leading.trailing.equalToSuperview().inset(23)
        }
        
        songView.leftSliderLabel.snp.makeConstraints { make in
            make.top.equalTo(songView.sliderView.snp.bottom).inset(-10)
            make.leading.equalToSuperview().inset(23)
        }
        
        songView.rightSliderLabel.snp.makeConstraints { make in
            make.top.equalTo(songView.sliderView.snp.bottom).inset(-10)
            make.trailing.equalToSuperview().inset(23)
        }
        
        songView.playButton.snp.makeConstraints { make in
            make.top.equalTo(songView.sliderView.snp.bottom).inset(-50)
            make.height.width.equalTo(74)
            make.centerX.equalToSuperview()
        }
        
        songView.previousTrackButton.snp.makeConstraints { make in
            make.centerY.equalTo(songView.playButton.snp.centerY)
            make.trailing.equalTo(songView.playButton.snp.leading).inset(-45)
        }
        
        songView.shuffleButton.snp.makeConstraints { make in
            make.centerY.equalTo(songView.playButton.snp.centerY)
            make.leading.equalToSuperview().inset(28)
        }
        
        songView.nextTrackButton.snp.makeConstraints { make in
            make.centerY.equalTo(songView.playButton.snp.centerY)
            make.leading.equalTo(songView.playButton.snp.trailing).inset(-45)
        }
        
        songView.repeatButton.snp.makeConstraints { make in
            make.centerY.equalTo(songView.playButton.snp.centerY)
            make.trailing.equalToSuperview().inset(28)
        }
    }
}
