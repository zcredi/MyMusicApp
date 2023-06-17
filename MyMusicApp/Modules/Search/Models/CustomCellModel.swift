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
}

extension CustomCellModel {
    
    static func getCustomArray() -> [CustomCellModel] {
        [
            CustomCellModel(avatarImageString: "plus.square", title: "1 Person", subtitle: "Subtitle1"),
            CustomCellModel(avatarImageString: "plus.square", title: "2 Person", subtitle: "Subtitle2"),
            CustomCellModel(avatarImageString: "plus.square", title: "3 Person", subtitle: "Subtitle3"),
            CustomCellModel(avatarImageString: "plus.square", title: "4 Person", subtitle: "Subtitle4"),
            CustomCellModel(avatarImageString: "plus.square", title: "5 Person", subtitle: "Subtitle5"),
            CustomCellModel(avatarImageString: "plus.square", title: "6 Person", subtitle: "Subtitle6"),
            CustomCellModel(avatarImageString: "plus.square", title: "7 Person", subtitle: "Subtitle7"),
            CustomCellModel(avatarImageString: "plus.square", title: "8 Person", subtitle: "Subtitle8"),
            CustomCellModel(avatarImageString: "plus.square", title: "9 Person", subtitle: "Subtitle9"),
            CustomCellModel(avatarImageString: "plus.square", title: "10 Person", subtitle: "Subtitle10")
        ]
    }
}
