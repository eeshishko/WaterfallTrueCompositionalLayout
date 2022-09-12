//
//  WaterfallTrueCompositionalLayout+LayoutBuilder.swift
//  
//
//  Created by Evgeny Shishko on 12.09.2022.
//

import UIKit

extension WaterfallTrueCompositionalLayout {
    final class LayoutBuilder {
        private var columnHeights: [CGFloat]
        private let columnCount: CGFloat
        private let itemSizeProvider: ItemSizeProvider
        private let interItemSpacing: CGFloat
        private let collectionWidth: CGFloat
        
        init(
            configuration: Configuration,
            collectionWidth: CGFloat
        ) {
            self.columnHeights = [CGFloat](repeating: 0, count: configuration.columnCount)
            self.columnCount = CGFloat(configuration.columnCount)
            self.itemSizeProvider = configuration.itemSizeProvider
            self.interItemSpacing = configuration.interItemSpacing
            self.collectionWidth = collectionWidth
        }
        
        func makeLayoutItem(for row: Int) -> NSCollectionLayoutGroupCustomItem {
            let frame = frame(for: row)
            columnHeights[columnIndex()] = frame.maxY + interItemSpacing
            return NSCollectionLayoutGroupCustomItem(frame: frame)
        }
        
        func maxColumnHeight() -> CGFloat {
            return columnHeights.max() ?? 0
        }
    }
}

private extension WaterfallTrueCompositionalLayout.LayoutBuilder {
    private var columnWidth: CGFloat {
        let spacing = (columnCount - 1) * interItemSpacing
        return (collectionWidth - spacing) / columnCount
    }
    
    func frame(for row: Int) -> CGRect {
        let width = columnWidth
        let height = itemHeight(for: row, itemWidth: width)
        let size = CGSize(width: width, height: height)
        let origin = itemOrigin(width: size.width)
        return CGRect(origin: origin, size: size)
    }
    
    private func itemOrigin(width: CGFloat) -> CGPoint {
        let y = columnHeights[columnIndex()].rounded()
        let x = (width + interItemSpacing) * CGFloat(columnIndex())
        return CGPoint(x: x, y: y)
    }
    
    private func itemHeight(for row: Int, itemWidth: CGFloat) -> CGFloat {
        let itemSize = itemSizeProvider(row)
        let aspectRatio = itemSize.height / itemSize.width
        let itemHeight = itemWidth * aspectRatio
        return itemHeight.rounded()
    }
    
    private func columnIndex() -> Int {
        columnHeights
            .enumerated()
            .min(by: { $0.element < $1.element })?
            .offset ?? 0
    }
}
