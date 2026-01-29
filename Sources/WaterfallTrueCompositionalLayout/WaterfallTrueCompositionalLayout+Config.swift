//
//  WaterfallTrueCompositionalLayout+Config.swift
//  
//
//  Created by Evgeny Shishko on 12.09.2022.
//

import UIKit

public extension WaterfallTrueCompositionalLayout {
    typealias ItemHeightProvider = (_ index: Int, _ itemWidth: CGFloat) -> CGFloat
    typealias ItemCountProvider = () -> Int
    typealias ColumnIndexProvider = (_ index: Int, _ columnCount: Int) -> Int

    /// Determines how items are assigned to columns in the waterfall layout
    enum ColumnBehavior {
        /// Items are placed in the column with the lowest current height (default waterfall behavior)
        case lowestHeight
        /// Items are placed sequentially across columns (0→col0, 1→col1, 2→col0, etc.)
        case sequential
        /// Custom column assignment via closure
        case custom(ColumnIndexProvider)
    }

    struct Configuration {
        public let columnCount: Int
        public let interItemSpacing: CGFloat
        public let contentInsetsReference: UIContentInsetsReference
        public let columnBehavior: ColumnBehavior
        public let itemHeightProvider: ItemHeightProvider
        public let itemCountProvider: ItemCountProvider

        /// Initialization for configuration of waterfall compositional layout section
        /// - Parameters:
        ///   - columnCount: a number of columns
        ///   - interItemSpacing: a spacing between columns and rows
        ///   - contentInsetsReference: a reference point for content insets for a section
        ///   - columnBehavior: determines how items are assigned to columns
        ///   - itemCountProvider: closure providing a number of items in a section
        ///   - itemHeightProvider: closure for providing an item height at a specific index
        public init(
            columnCount: Int = 2,
            interItemSpacing: CGFloat = 8,
            contentInsetsReference: UIContentInsetsReference = .automatic,
            columnBehavior: ColumnBehavior = .lowestHeight,
            itemCountProvider: @escaping ItemCountProvider,
            itemHeightProvider: @escaping ItemHeightProvider
        ) {
            self.columnCount = columnCount
            self.interItemSpacing = interItemSpacing
            self.contentInsetsReference = contentInsetsReference
            self.columnBehavior = columnBehavior
            self.itemCountProvider = itemCountProvider
            self.itemHeightProvider = itemHeightProvider
        }
    }
}
