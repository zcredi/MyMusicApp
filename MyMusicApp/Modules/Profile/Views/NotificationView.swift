//
//  NotificationView.swift
//  MyMusicApp
//
//  Created by Ilyas Tyumenev on 20.06.2023.
//

import UIKit
import SnapKit

protocol NotificationViewDelegate: AnyObject {
    func notificationView(_ view: NotificationView, switchStateDidChange sender: UISwitch)
}

class NotificationView: UIView {
    
    weak var delegate: NotificationViewDelegate?
    
    let notificationImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "notification")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let notificationLabel: UILabel = {
        let label = UILabel()
        label.text = "Notification"
        label.textColor = .neutralWhite
        label.font = .robotoRegular14()
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    let notificationSwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.set(width: 32, height: 17)
        mySwitch.tintColor = .neutralGray
        mySwitch.thumbTintColor = .white
        mySwitch.onTintColor = .brandGreen
        mySwitch.addTarget(self, action: #selector(switchStateDidChange), for: .valueChanged)
        mySwitch.setOn(true, animated: true)
        return mySwitch
    }()
    
    let dividerImage: UIImageView = {
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
extension NotificationView {
    
    private func setViews() {
        addSubview(notificationImage)
        addSubview(notificationLabel)
        addSubview(notificationSwitch)
        addSubview(dividerImage)
    }
    
    private func setupConstraints() {
        notificationImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(26)
            make.width.height.equalTo(20)
        }
        
        notificationLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(notificationImage.snp.trailing).offset(22)
        }
        
        notificationSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(26)
        }
        
        dividerImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
    }
}

// MARK: - Target Actions
private extension NotificationView {
    
    @objc func switchStateDidChange(_ sender: UISwitch) {
//        delegate?.notificationView(self, switchStateDidChange: sender)
        print("notificationSwitchTapped")
    }
}

// MARK: - UISwitch
extension UISwitch {

    func set(width: CGFloat, height: CGFloat) {
        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51

        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth

        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}
