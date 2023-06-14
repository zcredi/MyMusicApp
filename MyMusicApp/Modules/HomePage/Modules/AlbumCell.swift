//
//  AlbumCell.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 14.06.2023.
//

import UIKit
import Kingfisher

class AlbumCell: UICollectionViewCell {

    static let identifier = "AlbumCell"

    let songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let options: KingfisherOptionsInfo = [
        .transition(.fade(1)),
        .scaleFactor(UIScreen.main.scale),
        .cacheOriginalImage
    ]

    func configureCell(with musicResult: MusicResult) {
        songImageView.kf.setImage(with: URL(string: musicResult.artworkUrl100))
    }

    private func setupViews() {
        contentView.addSubview(songImageView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            songImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            songImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            songImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
}
