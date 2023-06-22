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
    
    private let backgroundView = UIView()
    private let songImageView = UIImageView()
    let songTitleLabel = UILabel()
    let songArtist = UILabel()
    private let backButton = UIButton(type: .system)
    let playButton = UIButton(type: .system)
    private let forwardButton = UIButton(type: .system)
    private var targetController: UIPageViewController?
    private var currentViewController: UIViewController?
    
    init() {
        super.init(frame: .zero)
        backgroundView.backgroundColor = .brandGreen
        setupViews()
        setupConstraints()
        addGestureToBackgroundView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(backgroundView)
        backgroundView.addSubview(songImageView)
        backgroundView.addSubview(songTitleLabel)
        backgroundView.addSubview(songArtist)
        backgroundView.addSubview(backButton)
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
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        songImageView.translatesAutoresizingMaskIntoConstraints = false
        songTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        songArtist.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            songImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            songImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            songImageView.widthAnchor.constraint(equalToConstant: 40),
            songImageView.heightAnchor.constraint(equalToConstant: 40),
            
            songTitleLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 8),
            songTitleLabel.topAnchor.constraint(equalTo: songImageView.topAnchor, constant: -2),
            songTitleLabel.widthAnchor.constraint(equalToConstant: 180),

            songArtist.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 8),
            songArtist.bottomAnchor.constraint(equalTo: songImageView.bottomAnchor, constant: -2),
            songArtist.widthAnchor.constraint(equalToConstant: 180),

            backButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -30),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            playButton.trailingAnchor.constraint(equalTo: forwardButton.leadingAnchor, constant: -30),
            playButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            forwardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26),
            forwardButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func updateSongTitle(_ title: String) {
        songTitleLabel.text = title
    }

    func updateSongArtist(_ title: String) {
        songArtist.text = title
    }

    func updateSongImage(_ image: UIImage?) {
        songImageView.image = image
    }
    
    func setupCurrentViewController(controller: UIViewController) {
        currentViewController = controller
    }
    
    func setupTargetController(controller: UIPageViewController) {
        targetController = controller
    }
    
    private func addGestureToBackgroundView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(switchToSongPageViewController))
        
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(gesture)
    }
    
    @objc private func switchToSongPageViewController() {
        guard let targetVC = targetController, let currentVC = currentViewController else { return }
        
        targetVC.modalPresentationStyle = .overFullScreen
        
        currentVC.present(targetVC, animated: true)
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

    func closeMiniPlayer() {
      self.removeFromSuperview()
    
  }

}
