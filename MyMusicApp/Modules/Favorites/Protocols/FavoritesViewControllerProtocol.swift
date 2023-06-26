//
//  FavoritesViewControllerProtocol.swift
//  MyMusicApp
//
//  Created by Евгений on 23.06.2023.
//

import Foundation

protocol FavoritesViewControllerProtocol: AnyObject {
    var songViewController: SongViewControllerProtocol? { get set }
    func appendFavoriteSong(_ model: Entry)
    func removeSongFromFavorites(selectedSong: Entry)
    func isCurrentSongFavorite(selectedSong: Entry) -> Bool
}
