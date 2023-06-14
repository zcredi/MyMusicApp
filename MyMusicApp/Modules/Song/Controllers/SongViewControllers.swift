//
//  SongViewControllers.swift
//  MyMusicApp
//
//  Created by Евгений on 13.06.2023.
//

import UIKit
import SnapKit
import SwiftUI

final class SongViewControllers: UIViewController {
    private var songView = SongView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brandBlack
        
        setViews()
        setConstraints()
    }
}

// Setup views:
extension SongViewControllers {
    private func setViews() {
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
extension SongViewControllers {
    private func setConstraints() {
        songView.songPageControl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(122)
            make.centerX.equalToSuperview()
        }
        
        songView.songImageView.snp.makeConstraints { make in
            make.width.height.equalTo(207)
            make.top.equalTo(songView.songPageControl.snp.bottom).inset(-52)
            make.centerX.equalToSuperview()
        }
        
        songView.songNameLabel.snp.makeConstraints { make in
            make.top.equalTo(songView.songImageView.snp.bottom).inset(-22)
            make.centerX.equalToSuperview()
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
            make.top.equalTo(songView.describingSongLabel.snp.bottom).inset(-30)
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
//
//struct ContentViewController: UIViewControllerRepresentable {
//
//    typealias UIViewControllerType = SongViewControllers
//
//    func makeUIViewController(context: Context) -> UIViewControllerType {
//        return SongViewControllers()
//    }
//
//    func updateUIViewController(_ uiViewController: SongViewControllers, context: Context) {}
//}
//
//struct ContentViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentViewController()
//            .edgesIgnoringSafeArea(.all)
//            .colorScheme(.light) // or .dark
//    }
//}
