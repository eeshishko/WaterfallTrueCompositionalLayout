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
        private let columnCount: Int
        private let columnBehavior: ColumnBehavior
        private let itemHeightProvider: ItemHeightProvider
        private let interItemSpacing: CGFloat
        private let collectionWidth: CGFloat

        init(
            configuration: Configuration,
            collectionWidth: CGFloat
        ) {
            self.columnHeights = [CGFloat](repeating: 0, count: configuration.columnCount)
            self.columnCount = configuration.columnCount
            self.columnBehavior = configuration.columnBehavior
            self.itemHeightProvider = configuration.itemHeightProvider
            self.interItemSpacing = configuration.interItemSpacing
            self.collectionWidth = collectionWidth
        }

        func makeLayoutItem(for row: Int) -> NSCollectionLayoutGroupCustomItem {
            let frame = frame(for: row)
            columnHeights[columnIndex(for: row)] = frame.maxY + interItemSpacing
            return NSCollectionLayoutGroupCustomItem(frame: frame)
        }

        func maxColumnHeight() -> CGFloat {
            return columnHeights.max() ?? 0
        }
    }
}

private extension WaterfallTrueCompositionalLayout.LayoutBuilder {
    var columnWidth: CGFloat {
        let spacing = CGFloat(columnCount - 1) * interItemSpacing
        return (collectionWidth - spacing) / CGFloat(columnCount)
    }

    func frame(for row: Int) -> CGRect {
        let width = columnWidth
        let height = itemHeightProvider(row, width)
        let size = CGSize(width: width, height: height)
        let origin = itemOrigin(for: row, width: size.width)
        return CGRect(origin: origin, size: size)
    }

    func itemOrigin(for row: Int, width: CGFloat) -> CGPoint {
        let column = columnIndex(for: row)
        let y = columnHeights[column].rounded()
        let x = (width + interItemSpacing) * CGFloat(column)
        return CGPoint(x: x, y: y)
    }

    func columnIndex(for row: Int) -> Int {
        switch columnBehavior {
        case .lowestHeight:
            return columnHeights
                .enumerated()
                .min(by: { $0.element < $1.element })?
                .offset ?? 0
        case .sequential:
            return row % columnCount
        case .custom(let provider):
            let index = provider(row, columnCount)
            return max(0, min(index, columnCount - 1))
        }
    }
}
