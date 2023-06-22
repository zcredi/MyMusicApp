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
    let musicPlayer = MusicPlayer.instance
    
    let songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let labelContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let albumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
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
        .processor(ResizingImageProcessor(referenceSize: CGSize(width: 600, height: 600))),
        .scaleFactor(UIScreen.main.scale),
        .cacheOriginalImage
    ]
    
    func configureCell(with musicResult: AlbumEntry) {
        albumLabel.text = musicResult.name.label
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
        contentView.addSubview(labelContainerView)
        labelContainerView.addSubview(authorLabel)
        labelContainerView.addSubview(albumLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            songImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            songImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            songImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            songImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            labelContainerView.leadingAnchor.constraint(equalTo: songImageView.leadingAnchor),
            labelContainerView.trailingAnchor.constraint(equalTo: songImageView.trailingAnchor),
            labelContainerView.bottomAnchor.constraint(equalTo: songImageView.bottomAnchor),
            
            authorLabel.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor, constant: -8),
            authorLabel.bottomAnchor.constraint(equalTo: albumLabel.topAnchor, constant: -2),
            
            albumLabel.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor, constant: 8),
            albumLabel.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor, constant: -8),
            albumLabel.bottomAnchor.constraint(equalTo: labelContainerView.bottomAnchor, constant: -8)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyLabelBackgroundColors()
    }
    
    private func applyLabelBackgroundColors() {
        let labelBackgroundAlpha: CGFloat = 0.6
        let labelBackgroundColor = UIColor(white: 0, alpha: labelBackgroundAlpha)
        
        if let authorLabelText = authorLabel.text {
            let attributedText = NSMutableAttributedString(string: authorLabelText)
            attributedText.addAttribute(.backgroundColor, value: labelBackgroundColor, range: NSRange(location: 0, length: attributedText.length))
            authorLabel.attributedText = attributedText
        }
        
        if let albumLabelText = albumLabel.text {
            let attributedText = NSMutableAttributedString(string: albumLabelText)
            attributedText.addAttribute(.backgroundColor, value: labelBackgroundColor, range: NSRange(location: 0, length: attributedText.length))
            albumLabel.attributedText = attributedText
        }
    }
}
