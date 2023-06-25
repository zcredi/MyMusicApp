//
//  ProfileSettingsView.swift
//  MyMusicApp
//
//  Created by Ilyas Tyumenev on 22.06.2023.
//

import UIKit
import SnapKit

protocol ProfileSettingsViewDelegate: AnyObject {
    func profileSettingsView(_ view: ProfileSettingsView, backButtonPressed button: UIButton)
    func profileSettingsView(_ view: ProfileSettingsView, cameraButtonPressed button: UIButton)    
    func profileSettingsView(_ view: ProfileSettingsView, changePasswordButtonPressed button: UIButton)
}

class ProfileSettingsView: UIView {
    
    weak var delegate: ProfileSettingsViewDelegate?
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Edit"
        label.textColor = .neutralWhite
        label.font = .robotoMedium18()
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "profileMock")
        image.layer.cornerRadius = 71
        image.layer.borderWidth = 3
        image.layer.borderColor = CGColor(red: 173, green: 176, blue: 192, alpha: 1)
        image.clipsToBounds = true
        return image
    }()
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.backgroundColor = .neutralBlack
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }()
    
    private let cameraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "photo"), for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(cameraButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let usernameView = UsernameView()
    let emailView = EmailView()
    let genderView = GenderView()
    let dateView = DateView()
    
    private let changePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change password", for: .normal)
        button.titleLabel?.font = .robotoRegular14()
        button.tintColor = .brandGreen
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(changePasswordButtonPressed), for: .touchUpInside)
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
extension ProfileSettingsView {
    
    private func setViews() {
        addSubview(backButton)
        addSubview(headerLabel)
        addSubview(backgroundImage)
        addSubview(profileImage)
        addSubview(cameraButton)
        addSubview(usernameView)
        addSubview(emailView)
        addSubview(genderView)
        addSubview(dateView)
        addSubview(changePasswordButton)
    }
    
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(64)
            make.leading.equalToSuperview().inset(28)
            make.width.height.equalTo(16)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(64)
            make.centerX.equalToSuperview()
            make.height.equalTo(21)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(183)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(133)
        }
        
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.top).offset(-67)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(142)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.bottom.equalTo(profileImage.snp.bottom)
            make.trailing.equalTo(profileImage.snp.trailing)
            make.height.width.equalTo(40)
        }
        
        usernameView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.top).offset(150)
            make.leading.equalTo(backgroundImage.snp.leading)
            make.trailing.equalTo(backgroundImage.snp.trailing)
            make.height.equalTo(70)
        }
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(usernameView.snp.bottom)
            make.leading.equalTo(backgroundImage.snp.leading)
            make.trailing.equalTo(backgroundImage.snp.trailing)
            make.height.equalTo(70)
        }
        
        genderView.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom)
            make.leading.equalTo(backgroundImage.snp.leading)
            make.trailing.equalTo(backgroundImage.snp.trailing)
            make.height.equalTo(70)
        }
        
        dateView.snp.makeConstraints { make in
            make.top.equalTo(genderView.snp.bottom)
            make.leading.equalTo(backgroundImage.snp.leading)
            make.trailing.equalTo(backgroundImage.snp.trailing)
            make.height.equalTo(70)
        }
        
        changePasswordButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(74)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - Target Actions
private extension ProfileSettingsView {
    
    @objc func backButtonPressed(_ button: UIButton) {
        delegate?.profileSettingsView(self, backButtonPressed: button)
    }
    
    @objc func changePasswordButtonPressed(_ button: UIButton) {
        delegate?.profileSettingsView(self, changePasswordButtonPressed: button)
    }
    
    @objc func cameraButtonPressed(_ button: UIButton) {
        delegate?.profileSettingsView(self, cameraButtonPressed: button)
    }
}
