//
//  TableViewCell.swift
//  MyMusicApp
//
//  Created by Ilyas Tyumenev on 14.06.2023.
//

import UIKit
import SnapKit

class ResultViewCell: UITableViewCell {

  static let cellId = String(describing: UITableViewCell.self)

  // MARK: - UI
  private let avatarImageView: UIImageView = {
    let image = UIImageView()
    image.clipsToBounds = true
    image.layer.cornerRadius = 3
    image.contentMode = .scaleAspectFill
    return image
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "titleLabel"
    label.textColor = .neutralWhite
    label.font = .robotoRegular16()
    label.numberOfLines = 1
    label.textAlignment = .left
    return label
  }()

  private let subtitleLabel: UILabel = {
    let label = UILabel()
    label.text = "subtitleLabel"
    label.textColor = .neutralGray
    label.font = .robotoRegular12()
    label.numberOfLines = 1
    label.textAlignment = .left
    return label
  }()

  private let ellipsisButton: UIButton = {
    let button = UIButton()
    button.frame = CGRect(x: 0, y: 0, width: 16, height: 4)
    button.setBackgroundImage(UIImage(systemName: "ellipsis"), for: .normal)
    button.tintColor = .neutralWhite
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

  // MARK: - Public Methods
  func configureCell(model: CustomCellModel) {
    titleLabel.text = model.title
    subtitleLabel.text = model.subtitle

    if let imageUrl = URL(string: model.avatarImageString) {
      URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, _, error) in
        guard let data = data, error == nil else {
          // Обработка ошибок загрузки изображения
          // Можно установить изображение по умолчанию или скрыть imageView
          DispatchQueue.main.async {
            self?.avatarImageView.image = UIImage(named: "default_image")
          }
          return
        }

        DispatchQueue.main.async {
          let image = UIImage(data: data)
          self?.avatarImageView.image = image
        }
      }.resume()
    }
  }
}

// MARK: - Set Views and Setup Constraints
extension ResultViewCell {
    
    private func setViews() {
        backgroundColor = .clear
        addSubview(avatarImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(ellipsisButton)
    }
    
    private func setupConstraints() {        
        avatarImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
            make.height.width.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15.5)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
        }
        
        ellipsisButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-28)
        }
    }
}
