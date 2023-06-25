//
//  RecentlyModel.swift
//  MyMusicApp
//
//  Created by Владислав on 24.06.2023.
//

import Foundation
import RealmSwift

class RecentlyModel: Object {
    @Persisted var songImage: String?
    @Persisted var songName: String = ""
    @Persisted var songAuthor: String = ""
    @Persisted var songStatus: Bool = false
}
