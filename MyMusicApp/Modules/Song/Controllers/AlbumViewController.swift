//
//  AlbumViewController.swift
//  MyMusicApp
//
//  Created by Евгений on 13.06.2023.
//

import UIKit
import SnapKit
import SwiftUI

struct Songs {
    var songName: String
    var performername: String
    var poster: UIImage
}

final class AlbumViewController: UIViewController {
    
    private let albumView = AlbumView()
    
    private let songsArray: [Songs] = [
    Songs(songName: "Come to me",
          performername: "Avinci John",
          poster: UIImage(named: "SongImage1") ?? UIImage.actions),
    Songs(songName: "Where can I get some ?",
          performername: "Alan Walker ",
          poster: UIImage(named: "SongImage2") ?? UIImage.actions),
    Songs(songName: "Why do we use it ?",
          performername: "Arian Grande",
          poster: UIImage(named: "SongImage3") ?? UIImage.actions)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumView.tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "Cell")
        albumView.tableView.dataSource = self
        albumView.tableView.delegate = self
        
        setViews()
        setConstraints()
    }
}

extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AlbumTableViewCell else { return UITableViewCell() }
        
        cell.numberCellLabel.text = "\(indexPath.row + 1)"
        cell.albumPosterImageView.image = songsArray[indexPath.row].poster
        cell.songNameLabel.text = songsArray[indexPath.row].songName
        cell.performerNameLabel.text = songsArray[indexPath.row].performername
        
        
        return cell
    }
}

extension AlbumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Suggestions"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.textColor = UIColor.white
    }
}

// Setup views:
extension AlbumViewController {
    private func setViews() {
        view.addSubview(albumView.backgroundImageView)
        view.addSubview(albumView.albumPageControl)
        view.addSubview(albumView.songNameLabel)
        view.addSubview(albumView.performerNameLabel)
        view.addSubview(albumView.describingSongLabel)
        view.addSubview(albumView.tableView)
        view.addSubview(albumView.separatororLine)
    }
}

// Setup views constraints:
extension AlbumViewController {
    private func setConstraints() {
        albumView.backgroundImageView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        albumView.albumPageControl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(122)
            make.centerX.equalToSuperview()
        }

        albumView.songNameLabel.snp.makeConstraints { make in
            make.top.equalTo(albumView.albumPageControl).inset(193)
            make.leading.equalToSuperview().inset(24)
        }

        albumView.performerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(albumView.songNameLabel.snp.bottom).inset(-4)
            make.leading.equalToSuperview().inset(24)
        }

        albumView.describingSongLabel.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.top.equalTo(albumView.performerNameLabel.snp.bottom).inset(-28)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(65)
        }
        
        albumView.tableView.snp.makeConstraints { make in
            make.top.equalTo(albumView.describingSongLabel.snp.bottom).inset(-60)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
        
        let widht = view.frame.width
        
        albumView.separatororLine.snp.makeConstraints { make in
            make.width.equalTo(widht - 30)
            make.height.equalTo(1)
            make.top.equalTo(albumView.describingSongLabel.snp.bottom).inset(-36)
            make.leading.trailing.equalToSuperview().inset(25)
        }
    }
}

struct ContentViewController: UIViewControllerRepresentable {

    typealias UIViewControllerType = AlbumViewController

    func makeUIViewController(context: Context) -> UIViewControllerType {
        return AlbumViewController()
    }

    func updateUIViewController(_ uiViewController: AlbumViewController, context: Context) {}
}

struct ContentViewController_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewController()
            .edgesIgnoringSafeArea(.all)
            .colorScheme(.light) // or .dark
    }
}
