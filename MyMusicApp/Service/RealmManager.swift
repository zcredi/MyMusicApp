//
//  RealmManager.swift
//  MyMusicApp
//
//  Created by Владислав on 22.06.2023.
//

import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    private init() {}
    
    let realm = try! Realm()
    
    func getResultWorkoutModel() -> Results<FavoriteModel> {
        realm.objects(FavoriteModel.self)
    }

    func saveWorkoutModel(_ model: FavoriteModel) {
        try! realm.write {
            realm.add(model)
        }
    }
    
    func deleteWorkoutModel(_ model: FavoriteModel) {
        try! realm.write {
            realm.delete(model)
        }
    }
}
