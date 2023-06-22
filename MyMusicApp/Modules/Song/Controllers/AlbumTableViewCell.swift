//
//  AlbumTableViewCell.swift
//  MyMusicApp
//
//  Created by Евгений on 13.06.2023.
//

import UIKit
import SnapKit

final class AlbumTableViewCell: UITableViewCell {
    lazy var numberCellLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoRegular14()
        label.textColor = .neutralWhite
        
        return label
    }()
    
    lazy var albumPosterImageView = UIImageView()
    
    lazy var songNameLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoRegular16()
        label.textColor = .neutralWhite
        
        return label
    }()
    
    lazy var performerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoRegular12()
        label.textColor = .neutralGray
        
        return label
    }()
    
    lazy var settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "settings.dots"), for: .normal)
        button.tintColor = .neutralWhite
        
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        backgroundColor = .systemGray.withAlphaComponent(0.4)
        
        setViews()
        setConstraints()
    }
}

// Setup views:
extension AlbumTableViewCell {
    private func setViews() {
        contentView.addSubview(numberCellLabel)
        contentView.addSubview(albumPosterImageView)
        contentView.addSubview(songNameLabel)
        contentView.addSubview(performerNameLabel)
        contentView.addSubview(settingButton)
    }
}

// Setup views constraints:
extension AlbumTableViewCell {
    private func setConstraints() {
        numberCellLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
        }
        
        albumPosterImageView.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.centerY.equalToSuperview()
            make.leading.equalTo(numberCellLabel.snp.trailing).inset(-21)
        }
        songNameLabel.snp.makeConstraints { make in
            make.top.equalTo(albumPosterImageView.snp.top)
            make.leading.equalTo(albumPosterImageView.snp.trailing).inset(-20)
        }
        
        performerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(songNameLabel.snp.bottom).inset(-4)
            make.leading.equalTo(albumPosterImageView.snp.trailing).inset(-20)
        }
        
        settingButton.snp.makeConstraints { make in
            make.height.equalTo(4)
            make.width.equalTo(16)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(28)
        }
    }
}
