//
//  SongCell.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 13.06.2023.
//

import UIKit
import Kingfisher

class SongCell: UICollectionViewCell {
  
  static let identifier = "SongCell"
  
  let songImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 8
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Song name"
    label.numberOfLines = 1
    label.lineBreakMode = .byTruncatingTail
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let authorLabel: UILabel = {
    let label = UILabel()
    label.text = "Author"
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
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
  
  func configureCell(with musicResult: Entry) {
    nameLabel.text = musicResult.name.label
    authorLabel.text = musicResult.artist.label

    if let imageUrlString = musicResult.images.first?.label,
       let imageUrl = URL(string: imageUrlString) {
      songImageView.kf.setImage(with: imageUrl)
    } else {
      songImageView.image = nil
    }
  }

  
  private func setupViews() {
    contentView.addSubview(songImageView)
    contentView.addSubview(nameLabel)
    contentView.addSubview(authorLabel)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      songImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      songImageView.heightAnchor.constraint(equalToConstant: 130),
      songImageView.widthAnchor.constraint(equalToConstant: 130),
      
      nameLabel.topAnchor.constraint(equalTo: songImageView.bottomAnchor, constant: 1),
      nameLabel.leadingAnchor.constraint(equalTo: songImageView.leadingAnchor),
      nameLabel.trailingAnchor.constraint(equalTo: songImageView.trailingAnchor),
      
      authorLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1),
      authorLabel.leadingAnchor.constraint(equalTo: songImageView.leadingAnchor),
      authorLabel.trailingAnchor.constraint(equalTo: songImageView.trailingAnchor)
    ])
  }
}
