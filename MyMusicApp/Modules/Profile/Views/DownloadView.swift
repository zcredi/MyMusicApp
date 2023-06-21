//
//  DownloadView.swift
//  MyMusicApp
//
//  Created by Ilyas Tyumenev on 20.06.2023.
//

import UIKit
import SnapKit

protocol DownloadViewDelegate: AnyObject {
    func downloadView(_ view: DownloadView, downloadButtonPressed button: UIButton)
}

class DownloadView: UIView {
    
    weak var delegate: DownloadViewDelegate?
    
    let downloadImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "downloadIcon")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let downloadLabel: UILabel = {
        let label = UILabel()
        label.text = "Download"
        label.textColor = .neutralWhite
        label.font = .robotoRegular14()
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "vector"), for: .normal)
        button.addTarget(self, action: #selector(downloadButtonPressed), for: .touchUpInside)
        return button
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
extension DownloadView {
    
    private func setViews() {
        addSubview(downloadImage)
        addSubview(downloadLabel)
        addSubview(downloadButton)
        addSubview(dividerImage)
    }
    
    private func setupConstraints() {
        downloadImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(26)
            make.width.height.equalTo(20)
        }
        
        downloadLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(downloadImage.snp.trailing).offset(22)
        }
        
        downloadButton.snp.makeConstraints { make in
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
private extension DownloadView {
    
    @objc func downloadButtonPressed(_ button: UIButton) {
//        delegate?.downloadView(self, downloadButtonPressed: button)
        print("downloadButtonPressed")
    }
}
