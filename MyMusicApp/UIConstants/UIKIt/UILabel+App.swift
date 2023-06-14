//
//  UILabel+App.swift
//  MyMusicApp
//
//  Created by Владислав on 13.06.2023.
//

import UIKit

extension UILabel {
    
    convenience init(text: String = "", font: UIFont?, textColor: UIColor) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.adjustsFontSizeToFitWidth = true
    }
}
