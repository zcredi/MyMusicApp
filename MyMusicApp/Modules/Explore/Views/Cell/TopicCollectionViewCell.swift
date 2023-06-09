//
//  TopicCollectionViewCell.swift
//  MyMusicApp
//
//  Created by Владислав on 14.06.2023.
//

import UIKit

class TopicCollectionViewCell: UICollectionViewCell {
    enum Constants {
        static let genreMusicImageSideSpacing: CGFloat = 0.0
        static let genreMusicImageHeightSpacing: CGFloat = 60.0
    }
  
    //MARK: - Create UI
    
     lazy var genreMusicImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "hiphop")
        image.layer.cornerRadius = 4
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true

        return image
    }()
    
    lazy var genreMusicLabel = UILabel(text: "Hip-Hop", font: .robotoBold14(), textColor: .neutralWhite)
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(genreMusicImage)
        genreMusicImage.addSubview(genreMusicLabel)
    }
}

extension TopicCollectionViewCell {
  private func setConstraints() {
      genreMusicImage.translatesAutoresizingMaskIntoConstraints = false
      genreMusicLabel.translatesAutoresizingMaskIntoConstraints = false

      NSLayoutConstraint.activate([
          genreMusicImage.centerXAnchor.constraint(equalTo: centerXAnchor),
          genreMusicImage.centerYAnchor.constraint(equalTo: centerYAnchor),
          genreMusicImage.widthAnchor.constraint(equalToConstant: 105),
          genreMusicImage.heightAnchor.constraint(equalToConstant: 70),

          genreMusicLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
          genreMusicLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
      ])
  }
}
