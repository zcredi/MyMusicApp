//
//  MiniPlayer.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 16.06.2023.
//

import UIKit

protocol MiniPlayerViewDelegate: AnyObject {
    func playButtonTapped()
    func forwardButtonTapped()
    func backwardButtonTapped()
}

class MiniPlayerVC: UIView {

  weak var delegate: MiniPlayerViewDelegate?

  private let songImageView = UIImageView()
  private let songTitleLabel = UILabel()
  private let backButton = UIButton(type: .system)
  private let playButton = UIButton(type: .system)
  private let forwardButton = UIButton(type: .system)

  init() {
    super.init(frame: .zero)
    backgroundColor = .brandGreen
    setupViews()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews() {
    addSubview(songImageView)
    addSubview(songTitleLabel)
    addSubview(backButton)
    backButton.setImage(UIImage(systemName: "backward.end"), for: .normal)
    backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    backButton.tintColor = .brandBlack

    addSubview(forwardButton)
    forwardButton.setImage(UIImage(systemName: "forward.end"), for: .normal)
    forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
    forwardButton.tintColor = .brandBlack

    addSubview(playButton)
    playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
    playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    playButton.tintColor = .brandBlack
  }

  private func setupConstraints() {

    songImageView.translatesAutoresizingMaskIntoConstraints = false
    songTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    backButton.translatesAutoresizingMaskIntoConstraints = false
    playButton.translatesAutoresizingMaskIntoConstraints = false
    forwardButton.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      songImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      songImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      songImageView.widthAnchor.constraint(equalToConstant: 40),
      songImageView.heightAnchor.constraint(equalToConstant: 40),

      songTitleLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 8),
      songTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

      backButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -30),
      backButton.centerYAnchor.constraint(equalTo: centerYAnchor),

      playButton.trailingAnchor.constraint(equalTo: forwardButton.leadingAnchor, constant: -30),
      playButton.centerYAnchor.constraint(equalTo: centerYAnchor),

      forwardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26),
      forwardButton.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }

  @objc private func backButtonTapped() {
    delegate?.backwardButtonTapped()
  }

  @objc private func playButtonTapped() {
    delegate?.playButtonTapped()
  }

  @objc private func forwardButtonTapped() {
    delegate?.forwardButtonTapped()
  }
}
