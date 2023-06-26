//
//  ProfileView.swift
//  MyMusicApp
//
//  Created by Ilyas Tyumenev on 20.06.2023.
//

import UIKit
import SnapKit

protocol ProfileViewDelegate: AnyObject {
    func profileView(_ view: ProfileView, settingsButtonPressed button: UIButton)
    func profileView(_ view: ProfileView, signOutButtonPressed button: UIButton)
}

class ProfileView: UIView {
    
    weak var delegate: ProfileViewDelegate?
    
    private let accountLabel: UILabel = {
        let label = UILabel()
        label.text = "Account"
        label.textColor = .neutralWhite
        label.font = .robotoBold48()
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let libraryLabel: UILabel = {
        let label = UILabel()
        label.text = "Library"
        label.textColor = .neutralWhite
        label.font = .robotoRegular22()
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let myPlaylistView = MyPlaylistView()
    private let notificationView = NotificationView()
    private let downloadView = DownloadView()
    
    private let signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGN OUT", for: .normal)
        button.titleLabel?.font = .robotoRegular16()
        button.tintColor = .brandGreen
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor(red: 0.796, green: 0.984, blue: 0.369, alpha: 1)
        button.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        return button
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
extension ProfileView {
    
    private func setViews() {
        addSubview(accountLabel)
        addSubview(settingsButton)
        addSubview(profileImage)
        addSubview(libraryLabel)
        addSubview(myPlaylistView)
        addSubview(notificationView)
        addSubview(downloadView)
        addSubview(signOutButton)
    }
    
    private func setupConstraints() {
        accountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(64)
            make.leading.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(86)
            make.trailing.equalToSuperview().inset(26)
            make.width.height.equalTo(20)
        }
        
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(accountLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().inset(24)
            make.width.height.equalTo(80)
        }
        
        libraryLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(26)
        }
        
        myPlaylistView.snp.makeConstraints { make in
            make.top.equalTo(libraryLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(53)
        }
        
        notificationView.snp.makeConstraints { make in
            make.top.equalTo(myPlaylistView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(53)
        }
        
        downloadView.snp.makeConstraints { make in
            make.top.equalTo(notificationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(53)
        }
        
        signOutButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(38)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(46)
        }
    }
}

// MARK: - Target Actions
private extension ProfileView {
    
    @objc func settingsButtonPressed(_ button: UIButton) {
        delegate?.profileView(self, settingsButtonPressed: button)
    }
    
    @objc func signOutButtonPressed(_ button: UIButton) {
        delegate?.profileView(self, signOutButtonPressed: button)
    }
}
