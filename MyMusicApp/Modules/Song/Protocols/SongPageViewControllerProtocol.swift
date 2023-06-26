//
//  SongPageViewControllerProtocol.swift
//  MyMusicApp
//
//  Created by Евгений on 25.06.2023.
//

import Foundation

protocol SongPageViewControllerProtocol {
    var trackInfo: Entry? { get set }
    func setFavoriteViewController(controller: FavoritesViewControllerProtocol)
}
