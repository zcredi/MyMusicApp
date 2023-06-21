//
//  FavoritesViewCell.swift
//  MyMusicApp
//
//  Created by Ilyas Tyumenev on 20.06.2023.
//

import UIKit
import SnapKit

protocol CellDelegate: AnyObject {
    func buttonPressed(_ cell: FavoritesViewCell)
}

class FavoritesViewCell: UITableViewCell {
    
    weak var delegate: CellDelegate?
    
    static let cellId = String(describing: UITableViewCell.self)
    
    // MARK: - UI
    private let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 3
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let songLabel: UILabel = {
        let label = UILabel()
        label.text = "titleLabel"
        label.textColor = .neutralWhite
        label.font = .robotoRegular16()
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let artistLabel: UILabel = {
       let label = UILabel()
        label.text = "subtitleLabel"
        label.textColor = .neutralGray
        label.font = .robotoRegular12()
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    let favoritesButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .neutralWhite
        button.addTarget(self, action: #selector(favoritesButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func favoritesButtonPressed(_ sender: UIButton) {
        delegate?.buttonPressed(self)
    }
    
    // MARK: - Public Methods
    func configureCell(model: CustomCellModel) {
        avatarImageView.image = UIImage(systemName: model.avatarImageString)
        songLabel.text = model.title
        artistLabel.text = model.subtitle
    }
}

// MARK: - Set Views and Setup Constraints
extension FavoritesViewCell {
    
    private func setViews() {
        backgroundColor = .clear
        addSubview(avatarImageView)
        addSubview(songLabel)
        addSubview(artistLabel)
        addSubview(favoritesButton)
    }
    
    private func setupConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
            make.height.width.equalTo(40)
        }
        
        songLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15.5)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
        }
        
        artistLabel.snp.makeConstraints { make in
            make.top.equalTo(songLabel.snp.bottom).offset(8)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
        }
        
        favoritesButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-28)
        }
    }
}
