//
//  CollectionViewCell.swift
//  MyMusicApp
//
//  Created by Ilyas Tyumenev on 14.06.2023.
//

import UIKit
import SnapKit

class CategoriesViewCell: UICollectionViewCell {
    
    static let cellId = String(describing: CategoriesViewCell.self)
    
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMedium16()
        label.textColor = .neutralGray
        label.textAlignment = .center
        return label
    }()
    
    private let underlineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "underline.png")
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                titleLabel.font = .robotoBold22()
                titleLabel.textColor = .neutralWhite
                underlineImageView.isHidden = false
            } else {
                titleLabel.font = .robotoMedium16()
                titleLabel.textColor = .neutralGray
                underlineImageView.isHidden = true
            }
        }
    }
    
    // MARK: - init
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
extension CategoriesViewCell {
    
    func setViews() {
        addSubview(titleLabel)
        addSubview(underlineImageView)
    }
    
    func configureCell(text: String) {
        titleLabel.text = text
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        underlineImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.height.equalTo(4)
        }
    }
}
