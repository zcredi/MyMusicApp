//
//  GenderView.swift
//  MyMusicApp
//
//  Created by Ilyas Tyumenev on 22.06.2023.
//

import UIKit
import SnapKit

class GenderView: UIView {
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.textColor = .neutralGray
        label.font = .robotoMedium14()
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    let genderTextField: UITextField = {
        let textField = UITextField()
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
extension GenderView {
    
    private func setViews() {
        addSubview(genderLabel)
        addSubview(genderTextField)
        addSubview(dividerImage)
    }
    
    private func setupConstraints() {
        genderLabel.snp.makeConstraints { make in
            make.bottom.equalTo(dividerImage.snp.top).offset(-14.5)
            make.leading.equalToSuperview().offset(16)
        }
        
        genderTextField.snp.makeConstraints { make in
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
