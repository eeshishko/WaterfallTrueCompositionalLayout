//
//  WaterfallTrueCompositionalLayout+Config.swift
//  
//
//  Created by Evgeny Shishko on 12.09.2022.
//

import UIKit

public extension WaterfallTrueCompositionalLayout {
    typealias ItemSizeProvider = (Int) -> CGSize
    typealias ItemCountProvider = () -> Int
    
    struct Configuration {
        public let columnCount: Int
        public let interItemSpacing: CGFloat
        public let contentInsetsReference: UIContentInsetsReference
        public let itemSizeProvider: ItemSizeProvider
        public let itemCountProvider: ItemCountProvider
            
        public init(
            columnCount: Int = 2,
            interItemSpacing: CGFloat = 8,
            contentInsetsReference: UIContentInsetsReference = .automatic,
            itemCountProvider: @escaping ItemCountProvider,
            itemSizeProvider: @escaping ItemSizeProvider
        ) {
            self.columnCount = columnCount
            self.interItemSpacing = interItemSpacing
            self.contentInsetsReference = contentInsetsReference
            self.itemCountProvider = itemCountProvider
            self.itemSizeProvider = itemSizeProvider
        }
    }
}
