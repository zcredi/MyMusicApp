//
//  UsernameView.swift
//  MyMusicApp
//
//  Created by Ilyas Tyumenev on 22.06.2023.
//

import UIKit
import SnapKit

class UsernameView: UIView {
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textColor = .neutralGray
        label.font = .robotoMedium14()
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.text = "John Huston"
        textField.textColor = .neutralWhite
        textField.font = .robotoMedium16()
        textField.textAlignment = .right
        return textField
    }()
    
    let dividerImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "dividerSettings")
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
extension UsernameView {
    
    private func setViews() {
        addSubview(usernameLabel)
        addSubview(usernameTextField)
        addSubview(dividerImage)
    }
    
    private func setupConstraints() {
        usernameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(dividerImage.snp.top).offset(-14.5)
            make.leading.equalToSuperview().offset(16)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.bottom.equalTo(dividerImage.snp.top).offset(-13.5)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(200)
        }
        
        dividerImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
    }
}

// MARK: - UITextFieldDelegate
extension UsernameView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
