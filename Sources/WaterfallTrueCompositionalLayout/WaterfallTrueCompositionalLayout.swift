import UIKit

/// Pinterest/waterfall like layout allows to have shifted items of different heights independently
public final class WaterfallTrueCompositionalLayout {
    /// Creates `NSCollectionLayoutSection` instance  for `WaterfallTrueCompositionalLayout`
    /// - Parameters:
    ///   - config: Parameters describing your desired layout
    ///   - environment: environment which is accessible on provider closure for UICollectionView
    ///   - sectionIndex: index of a section in certain UICollectionView
    /// - Returns: Pinterest-like layout
    public static func makeLayoutSection(
        config: Configuration,
        environment: NSCollectionLayoutEnvironment,
        sectionIndex: Int
    ) -> NSCollectionLayoutSection {
        var items = [NSCollectionLayoutGroupCustomItem]()
        let itemProvider = LayoutBuilder(
            configuration: config,
            collectionWidth: environment.container.contentSize.width
        )
        for i in 0..<config.itemCountProvider() {
            let item = itemProvider.makeLayoutItem(for: i)
            items.append(item)
        }
        
        let groupLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(itemProvider.maxColumnHeight())
        )
        
        let group = NSCollectionLayoutGroup.custom(layoutSize: groupLayoutSize) { _ in
            return items
        }
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsetsReference = config.contentInsetsReference
        return section
    }
}
