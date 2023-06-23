//
//  RecentlyModel.swift
//  MyMusicApp
//
//  Created by Владислав on 22.06.2023.
//

import Foundation
import RealmSwift

class RecentlyModel: Object {
    @Persisted var songImage: Data?
    @Persisted var songName: String = ""
    @Persisted var songAuthor: String = ""
    @Persisted var songStatus: Bool = false
}
