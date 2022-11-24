//
//  ItemModel.swift
//  WaterfallTrueCompositionalLayoutDemo
//
//  Created by Evgeny Shishko on 19.09.2022.
//

import Foundation
import UIKit

struct ItemModel: Hashable {
    let title: String
    let color = randomColor()
    let height = CGFloat.random(in: 30...100)
    
    private static func randomColor() -> UIColor {
        let hue = CGFloat(arc4random() % 256) / 256
        let saturation = CGFloat(arc4random() % 128) / 256 + 0.5
        let brightness = CGFloat(arc4random() % 128) / 256 + 0.5
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
