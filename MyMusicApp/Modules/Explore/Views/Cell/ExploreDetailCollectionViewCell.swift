//
//  ExploreDetailCollectionViewCell.swift
//  MyMusicApp
//
//  Created by Владислав on 20.06.2023.
//

import UIKit

class ExploreDetailCollectionViewCell: UICollectionViewCell {
  enum Constants {
    static let numberMusicLabelLeadingSpacing: CGFloat = 0.0
    static let musicImageTopSpacing: CGFloat = 3.0
    static let musicImageLeadingSpacing: CGFloat = 20.0
    static let nameMusicLabelTopSpacing: CGFloat = 0.0
    static let nameMusicLabelLeadingSpacing: CGFloat = 20.0
    static let authorMusicLabelTopSpacing: CGFloat = 4.0
    static let authorMusicLabelLeadingSpacing: CGFloat = 20.0
    static let settingsButtonTrailingSpacing: CGFloat = 0.0
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
  
  private lazy var settingsButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "settings.dots"), for: .normal)
    button.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
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
  private func settingsButtonPressed(_ sender: UIButton) {
    print("settings")
  }
  
  private func setupViews() {
    
    addSubview(numberMusicLabel)
    addSubview(musicImage)
    addSubview(nameMusicLabel)
    addSubview(authorMusicLabel)
    addSubview(settingsButton)
  }
  
  func configureCell(with musicResult: Entry, songNumber: Int) {
    numberMusicLabel.text = songNumber.description
    nameMusicLabel.text = musicResult.name.label
    authorMusicLabel.text = musicResult.artist.label
    
    if let imageUrlString = musicResult.images.first?.label,
       let imageUrl = URL(string: imageUrlString) {
      musicImage.kf.setImage(with: imageUrl)
    } else {
      musicImage.image = nil
    }
  }
}

extension ExploreDetailCollectionViewCell {
      private func setConstraints() {
          numberMusicLabel.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              numberMusicLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.numberMusicLabelLeadingSpacing),
              numberMusicLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
          ])
          musicImage.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              musicImage.centerYAnchor.constraint(equalTo: centerYAnchor),
              musicImage.leadingAnchor.constraint(equalTo: numberMusicLabel.trailingAnchor, constant: Constants.musicImageLeadingSpacing),
              musicImage.widthAnchor.constraint(equalToConstant: 40),
              musicImage.heightAnchor.constraint(equalToConstant: 40)
          ])
          nameMusicLabel.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              nameMusicLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.nameMusicLabelTopSpacing),
              nameMusicLabel.leadingAnchor.constraint(equalTo: musicImage.trailingAnchor, constant: Constants.nameMusicLabelLeadingSpacing),
              nameMusicLabel.widthAnchor.constraint(equalToConstant: 190)
          ])
          authorMusicLabel.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              authorMusicLabel.topAnchor.constraint(equalTo: nameMusicLabel.bottomAnchor, constant: Constants.authorMusicLabelTopSpacing),
              authorMusicLabel.leadingAnchor.constraint(equalTo: musicImage.trailingAnchor, constant: Constants.authorMusicLabelLeadingSpacing),
              nameMusicLabel.widthAnchor.constraint(equalToConstant: 190)
          ])
          settingsButton.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.settingsButtonTrailingSpacing),
              settingsButton.centerYAnchor.constraint(equalTo: centerYAnchor)
          ])
      }
  }
