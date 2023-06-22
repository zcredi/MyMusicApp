//
//  AlbumCollectionViewCell.swift
//  MyMusicApp
//
//  Created by Владислав on 20.06.2023.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    enum Constants {
        static let genreMusicImageSideSpacing: CGFloat = 0.0
        static let genreMusicImageHeightSpacing: CGFloat = 155.0
    }
    
    //MARK: - Create UI
    
    private lazy var genreMusicImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "albumImg")
        image.layer.cornerRadius = 4
        return image
    }()
    
    private lazy var genreMusicLabel = UILabel(text: "Rap Gangz", font: .robotoBold14(), textColor: .neutralWhite)
    
    private lazy var playImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "playWhiteS"))
        return imageView
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ellipseS"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(playerButtonTapped), for: .touchUpInside)
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
    private func playerButtonTapped() {
        print("playGenre")
    }
    
    private func setupViews() {
        addSubview(genreMusicImage)
        genreMusicImage.addSubview(genreMusicLabel)
        addSubview(playButton)
        playButton.addSubview(playImage)
    }
}

extension AlbumCollectionViewCell {
    private func setConstraints() {
        genreMusicImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genreMusicImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            genreMusicImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        genreMusicLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genreMusicLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            genreMusicLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.trailingAnchor.constraint(equalTo: genreMusicImage.trailingAnchor, constant: -10),
            playButton.bottomAnchor.constraint(equalTo: genreMusicImage.bottomAnchor, constant: -10)
        ])
        playImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playImage.topAnchor.constraint(equalTo: playButton.topAnchor, constant: 6),
            playImage.leadingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: 9),
            playImage.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
}
