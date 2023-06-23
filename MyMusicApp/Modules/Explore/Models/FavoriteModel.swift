//
//  FavoriteModel.swift
//  MyMusicApp
//
//  Created by Владислав on 22.06.2023.
//

import Foundation
import RealmSwift

class FavoriteModel: Object {
    @Persisted var songNumber: Int = 0
    @Persisted var songImage: Data?
    @Persisted var songName: String = ""
    @Persisted var songAuthor: String = ""
}
