//
//  FavoritesModel.swift
//  MyMusicApp
//
//  Created by Владислав on 25.06.2023.
//

import Foundation
import RealmSwift

class FavoritesModel: Object {
    @Persisted var songImage: String?
    @Persisted var songName: String = ""
    @Persisted var songAuthor: String = ""
    @Persisted var favoriteStatus: Bool = false
}
