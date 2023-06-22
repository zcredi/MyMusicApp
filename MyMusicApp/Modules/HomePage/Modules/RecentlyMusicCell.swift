//
//  RecentlyMusicCell.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 13.06.2023.
//

import UIKit
import Kingfisher

class RecommendedCell: UITableViewCell {
  
  static let identifier = "SongCell"
  
  let songNumberLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.textColor = .white
    label.font = UIFont.robotoRegular16()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
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
    label.textAlignment = .left
    label.numberOfLines = 2
    label.font = UIFont.robotoRegular14()
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let authorLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.font = UIFont.robotoRegular12()
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let playButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "play"), for: .normal)
    button.tintColor = .white
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureCell(with musicResult: Entry, songNumber: Int) {
    nameLabel.text = musicResult.name.label
    authorLabel.text = musicResult.artist.label
    songNumberLabel.text = songNumber.description
    if let imageUrlString = musicResult.images.first?.label,
       let imageUrl = URL(string: imageUrlString) {
      songImageView.kf.setImage(with: imageUrl)
    } else {
      songImageView.image = nil
    }
  }
  
  private func setupViews() {
    backgroundColor = .clear
    contentView.addSubview(songNumberLabel)
    contentView.addSubview(songImageView)
    contentView.addSubview(nameLabel)
    contentView.addSubview(authorLabel)
    contentView.addSubview(playButton)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      songNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      songNumberLabel.widthAnchor.constraint(equalToConstant: 18),
      songNumberLabel.heightAnchor.constraint(equalToConstant: 16),
      songNumberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      
      songImageView.leadingAnchor.constraint(equalTo: songNumberLabel.trailingAnchor, constant: 8),
      songImageView.widthAnchor.constraint(equalToConstant: 40),
      songImageView.heightAnchor.constraint(equalToConstant: 40),
      songImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      
      nameLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 4),
      nameLabel.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: 4),
      nameLabel.topAnchor.constraint(equalTo: songImageView.topAnchor),
      
      authorLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 4),
      authorLabel.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: 4),
      authorLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
      
      playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      playButton.widthAnchor.constraint(equalToConstant: 15),
      playButton.heightAnchor.constraint(equalTo: playButton.widthAnchor)
    ])
  }
}
