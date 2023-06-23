//
//  MyPlaylistView.swift
//  MyMusicApp
//
//  Created by Ilyas Tyumenev on 20.06.2023.
//

import UIKit
import SnapKit

protocol MyPlaylistViewDelegate: AnyObject {
    func myPlaylistView(_ view: MyPlaylistView, myPlaylistButtonPressed button: UIButton)
}

class MyPlaylistView: UIView {
    
    weak var delegate: MyPlaylistViewDelegate?
    
    private let myPlaylistImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "playlist")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let myPlaylistLabel: UILabel = {
        let label = UILabel()
        label.text = "My playlist"
        label.textColor = .neutralWhite
        label.font = .robotoRegular14()
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let myPlaylistButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "vector"), for: .normal)
        button.addTarget(self, action: #selector(myPlaylistButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let dividerImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "divider")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    

// MARK: - Set Views and Setup Constraints
extension MyPlaylistView {
    
    private func setViews() {
        addSubview(myPlaylistImage)
        addSubview(myPlaylistLabel)
        addSubview(myPlaylistButton)
        addSubview(dividerImage)
    }
    
    private func setupConstraints() {
        myPlaylistImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(26)
            make.width.height.equalTo(20)
        }
        
        myPlaylistLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(myPlaylistImage.snp.trailing).offset(22)
        }
        
        myPlaylistButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(32)
            make.height.equalTo(12)
            make.width.equalTo(8)
        }
        
        dividerImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
    }
}

// MARK: - Target Actions
private extension MyPlaylistView {
    
    @objc func myPlaylistButtonPressed(_ button: UIButton) {
//        delegate?.myPlaylistView(self, myPlaylistButtonPressed: button)
        print("myPlaylistButtonPressed")
    }
}
