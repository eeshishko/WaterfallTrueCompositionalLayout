/**
 * UIKitHelpers
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import Combine
import UIKit

@available(iOS 13.0, *)
public extension UIMenu {
    
    static func picker<Item: Equatable>(
        title: String,
        symbolName: String,
        items: [Item],
        itemTitle: (Item) -> String,
        itemSubject: CurrentValueSubject<Item, Never>
    ) -> UIMenu {
        picker(
            title: title,
            symbolName: symbolName,
            items: items,
            itemTitle: itemTitle,
            isItemSelected: { itemSubject.value == $0 },
            didSelectItem: itemSubject.send
        )
    }
    
    static func picker<Item: Equatable>(
        title: String,
        symbolName: String,
        items: [Item],
        itemTitle: (Item) -> String,
        isItemSelected: (Item) -> Bool,
        didSelectItem: @escaping (Item) -> Void
    ) -> UIMenu {
        UIMenu(
            title: title,
            image: UIImage(systemName: symbolName),
            children: items.map { item in
                UIAction(
                    title: itemTitle(item),
                    state: isItemSelected(item) ? .on : .off,
                    handler: { _ in
                        didSelectItem(item)
                    }
                )
            }
        )
    }
}
