//
//  AllSongsViewController.swift
//  MyMusicApp
//
//  Created by Александра Савчук on 20.06.2023.
//

import UIKit

class AllSongsViewController: UIViewController {
    private let newSongsView = NewSongsView()
    private let musicPlayer = MusicPlayer.instance
    private let miniPlayerVC = MiniPlayerVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
        setupConstraints()
        fetchNewSongs()
        miniPlayerVC.delegate = self
        musicPlayer.delegate = self
    }
    
    private func fetchNewSongs() {
        let networkService = NetworkService()
        networkService.fetchMusicDataFromAPI(urlString: "https://itunes.apple.com/us/rss/topsongs/limit=25/json") { result in
            switch result {
            case .success(let musicResponse):
                DispatchQueue.main.async {
                    Music.shared.musicResults = musicResponse.feed.entry
                    self.newSongsView.update(with: Music.shared.musicResults)
                }
            case .failure(let error):
                print("Error fetching music data: \(error)")
            }
        }
    }
    
    private func setupViews() {
        view.addSubview(newSongsView)
        newSongsView.delegate = self
    }
    
    private func setupConstraints() {
        newSongsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newSongsView.topAnchor.constraint(equalTo: view.topAnchor),
            newSongsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newSongsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newSongsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)
        ])
    }
    
    func showMiniPlayer() {
        miniPlayerVC.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(miniPlayerVC)
        NSLayoutConstraint.activate([
            miniPlayerVC.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            miniPlayerVC.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            miniPlayerVC.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            miniPlayerVC.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}

extension AllSongsViewController: NewSongsViewDelegate {
    //MARK: - NewSongsViewDelegate
    
    func newSongsView(_ newSongsView: NewSongsView, didSelectSongAt indexPath: IndexPath) {
        let selectedSong = newSongsView.songs[indexPath.row]
        if let audioURL = selectedSong.links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href {
            showMiniPlayer()
            if musicPlayer.isPlayingMusic(from: audioURL) {
                musicPlayer.pauseMusic()
            } else {
                musicPlayer.loadPlayer(from: audioURL)
            }
        } else {
            print("Error: No audio URL available")
        }
    }
}

extension AllSongsViewController: MiniPlayerViewDelegate {
    func forwardButtonTapped() {
        musicPlayer.playNextSong()
    }
    
    func backwardButtonTapped() {
        musicPlayer.playPreviousSong()
    }
    
    func playButtonTapped() {
        musicPlayer.pauseMusic()
    }
    
}

extension AllSongsViewController: MusicPlayerDelegate {
    
    func updateCurrentURL(_ url: String) {
        guard let musicResult = getMusicResultFromURL(url)
        else {
            miniPlayerVC.updateSongTitle("")
            miniPlayerVC.updateSongImage(nil)
            return
        }
        miniPlayerVC.updateSongTitle(musicResult.name.label)
        if let imageUrlString = musicResult.images.first?.label,
           let imageUrl = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                DispatchQueue.main.async {
                    if let imageData = data, let image = UIImage(data: imageData) {
                        self.miniPlayerVC.updateSongImage(image)
                    } else {
                        self.miniPlayerVC.updateSongImage(nil)
                    }
                }
            }.resume()
        } else {
            miniPlayerVC.updateSongImage(nil)
        }
    }
    
    private func getMusicResultFromURL(_ url: String) -> Entry? {
        let entry = Music.shared.musicResults.first { $0.links.first(where: { $0.attributes.rel == "enclosure" })?.attributes.href  == url }
        return entry
    }
    
    func updatePlayButtonState(isPlaying: Bool) {
        
        if isPlaying {
            miniPlayerVC.playButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            miniPlayerVC.playButton.tintColor = .brandBlack
        } else {
            miniPlayerVC.playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
            miniPlayerVC.playButton.tintColor = .brandBlack
        }
    }
}


