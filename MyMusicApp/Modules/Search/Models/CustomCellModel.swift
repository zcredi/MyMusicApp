//
//  CustomCellModel.swift
//  MyMusicApp
//
//  Created by Ilyas Tyumenev on 14.06.2023.
//

import Foundation

struct CustomCellModel {
    let avatarImageString: String
    let title: String
    let subtitle: String
    let album: String
    let url: String
}

extension CustomCellModel {

    static func getCustomArray() -> [CustomCellModel] {
        []
    }

    func updated(with musicResults: MusicResult) -> CustomCellModel {
        CustomCellModel(
            avatarImageString: musicResults.artworkUrl100,
            title: musicResults.trackName ?? "",
            subtitle: musicResults.artistName,
            album: musicResults.collectionName ?? "",
            url: musicResults.previewUrl ?? ""
        )
    }
}
