//
//  RecentlyCollectionViewCell.swift
//  MyMusicApp
//
//  Created by Владислав on 13.06.2023.
//

import UIKit

class RecentlyCollectionViewCell: UICollectionViewCell {
    enum Constants {
        static let numberMusicLabelLeadingSpacing: CGFloat = 10.0
        static let musicImageTopSpacing: CGFloat = 7.0
        static let musicImageLeadingSpacing: CGFloat = 20.0
        static let nameMusicLabelTopSpacing: CGFloat = 7.0
        static let nameMusicLabelLeadingSpacing: CGFloat = 16.0
        static let authorMusicLabelTopSpacing: CGFloat = 4.0
        static let authorMusicLabelLeadingSpacing: CGFloat = 16.0
        static let playButtonTrailingSpacing: CGFloat = 16.0
    }
    
    //MARK: - Create UI

    private lazy var numberMusicLabel = UILabel(text: "01", font: .robotoRegular14(), textColor: .neutralWhite)
    
    private lazy var nameMusicLabel = UILabel(text: "Nice For What", font: .robotoRegular16(), textColor: .neutralWhite)
    
    private lazy var authorMusicLabel = UILabel(text: "Avinci John", font: .robotoRegular12(), textColor: .neutralGray)
    
    private lazy var musicImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "rectangle")
        image.layer.cornerRadius = 3
        return image
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "play"), for: .normal)
        button.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc
        private func playButtonPressed(_ sender: UIButton) {
            let isPlaying = sender.isSelected
            sender.isSelected = !isPlaying
            isPlaying ? playButton.setImage(UIImage(named: "play"), for: .normal) : playButton.setImage(UIImage(named: "stop"), for: .normal)
        }
    
    public func configure(model: RecentlyModel, songNumber: Int) {
        nameMusicLabel.text = model.songName
        authorMusicLabel.text = model.songAuthor
        numberMusicLabel.text = songNumber.description
        
        if model.songStatus {
            playButton.setImage(UIImage(systemName: "stop"), for: .normal)
        } else {
            playButton.setImage(UIImage(systemName: "play"), for: .normal)
        }
        
        if let imageUrlString = model.songImage,
           let imageUrl = URL(string: imageUrlString) {
            musicImage.kf.setImage(with: imageUrl)
        } else {
            musicImage.image = nil
        }
    }
    
    private func setupViews() {

        addSubview(numberMusicLabel)
        addSubview(musicImage)
        addSubview(nameMusicLabel)
        addSubview(authorMusicLabel)
        addSubview(playButton)
    }
}

extension RecentlyCollectionViewCell {
    private func setConstraints() {
        numberMusicLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            numberMusicLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.numberMusicLabelTopSpacing),
            numberMusicLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.numberMusicLabelLeadingSpacing),
            numberMusicLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        musicImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            musicImage.topAnchor.constraint(equalTo: topAnchor, constant: Constants.musicImageTopSpacing),
            musicImage.leadingAnchor.constraint(equalTo: numberMusicLabel.trailingAnchor, constant: Constants.musicImageLeadingSpacing),
            musicImage.widthAnchor.constraint(equalToConstant: 40),
            musicImage.heightAnchor.constraint(equalToConstant: 40)
        ])
        nameMusicLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameMusicLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.nameMusicLabelTopSpacing),
            nameMusicLabel.leadingAnchor.constraint(equalTo: musicImage.trailingAnchor, constant: Constants.nameMusicLabelLeadingSpacing),
//            nameMusicLabel.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -5)
        ])
        authorMusicLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorMusicLabel.topAnchor.constraint(equalTo: nameMusicLabel.bottomAnchor, constant: Constants.authorMusicLabelTopSpacing),
            authorMusicLabel.leadingAnchor.constraint(equalTo: musicImage.trailingAnchor, constant: Constants.authorMusicLabelLeadingSpacing),
//            authorMusicLabel.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -5)
        ])
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.playButtonTrailingSpacing),
            playButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
