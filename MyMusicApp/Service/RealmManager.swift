//
//  RealmManager.swift
//  MyMusicApp
//
//  Created by Владислав on 24.06.2023.
//

import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    private init() {}
    
    let realm = try! Realm()
    
    func getResultRecentlyModel() -> Results<RecentlyModel> {
        realm.objects(RecentlyModel.self)
    }

    func saveRecentlyModel(_ model: RecentlyModel) {
        try! realm.write {
            realm.add(model)
        }
    }
    
    func deleteRecentlyModel(_ model: RecentlyModel) {
        try! realm.write {
            let object = realm.objects(RecentlyModel.self).filter("songName = %@", model.songName)
            realm.delete(object)
        }
    }
    
    func deleteAllRecentlyModel() {
        try! realm.write {
            print("deleteAll")
            realm.deleteAll()
        }
    }
}
