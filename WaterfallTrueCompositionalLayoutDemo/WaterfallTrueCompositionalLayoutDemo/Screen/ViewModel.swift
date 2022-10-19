//
//  ViewModel.swift
//  WaterfallTrueCompositionalLayoutDemo
//
//  Created by Evgeny Shishko on 19.09.2022.
//

import Combine
import WaterfallTrueCompositionalLayout
import UIKit

final class ViewModel {
    lazy var layoutConfiguration = Publishers.CombineLatest3(
        columnCountSubject,
        spacingSubject,
        contentInsetsReferenceSubject
    ).map { [unowned self] _, _, _ in
        makeWaterfallLayoutConfiguration()
    }.eraseToAnyPublisher()
    lazy var menu = Publishers.CombineLatest3(
        columnCountSubject,
        spacingSubject,
        contentInsetsReferenceSubject
    ).map { [unowned self] _, _, _ in
        makeMenu()
    }.eraseToAnyPublisher()
    lazy var snapshot = itemsSubject.map { items -> NSDiffableDataSourceSnapshot<Int, ItemModel> in
        var snapshot = NSDiffableDataSourceSnapshot<Int, ItemModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        return snapshot
    }.eraseToAnyPublisher()
    
    private let columnCountSubject = CurrentValueSubject<Int, Never>(Constants.columnCount)
    private let spacingSubject = CurrentValueSubject<CGFloat, Never>(Constants.spacing)
    private let contentInsetsReferenceSubject = CurrentValueSubject<UIContentInsetsReference, Never>(Constants.contentInsetsReference)
    private let itemsSubject = CurrentValueSubject<[ItemModel], Never>(makeItems())
    
    init() {}
    
    func removeItem(at indexPath: IndexPath) {
        itemsSubject.value.remove(at: indexPath.row)
    }
    
    private func reset() {
        columnCountSubject.value = Constants.columnCount
        spacingSubject.value = Constants.spacing
        contentInsetsReferenceSubject.value = Constants.contentInsetsReference
        itemsSubject.value = ViewModel.makeItems()
    }
    
    private func makeWaterfallLayoutConfiguration() -> WaterfallTrueCompositionalLayout.Configuration {
        .init(
            columnCount: columnCountSubject.value,
            interItemSpacing: spacingSubject.value,
            contentInsetsReference: contentInsetsReferenceSubject.value,
            itemCountProvider: { [weak self] in
                self?.itemsSubject.value.count ?? 0
            },
            itemHeightProvider: { [weak self] row, _ in
                self?.itemsSubject.value[row].height ?? 0
            }
        )
    }
    
    private func makeMenu() -> UIMenu {
        UIMenu(
            title: "Edit Layout",
            children: [
                UIMenu(
                    options: .displayInline,
                    children: [
                        makeColumnCountSelectionMenu(),
                        makeSpacingSelectionMenu(),
                        makeContentInsetsReferenceMenu()
                    ]
                ),
                UIMenu(
                    options: .displayInline,
                    children: [
                        makeResetAction()
                    ]
                )
            ]
        )
    }
    
    private func makeColumnCountSelectionMenu() -> UIMenu {
        UIMenu.picker(
            title: "Column Count",
            symbolName: "building.columns",
            items: [1, 2, 3, 4, 5, 6, 7, 8],
            itemTitle: String.init,
            itemSubject: columnCountSubject
        )
    }
    
    private func makeSpacingSelectionMenu() -> UIMenu {
        UIMenu.picker(
            title: "Spacing",
            symbolName: "arrow.left.and.right",
            items: [0, 2, 8, 16],
            itemTitle: { String(format: "%.0f pt", $0) },
            itemSubject: spacingSubject
        )
    }
    
    private func makeContentInsetsReferenceMenu() -> UIMenu {
        UIMenu.picker(
            title: "Content Insets Reference",
            symbolName: "squareshape.dashed.squareshape",
            items: [.automatic, .none, .safeArea, .layoutMargins, .readableContent],
            itemTitle: { reference in
                switch reference {
                case .automatic:
                    return "Automatic"
                case .none:
                    return "None"
                case .safeArea:
                    return "Safe Area"
                case .layoutMargins:
                    return "Layout Margins"
                case .readableContent:
                    return "Readable Content"
                @unknown default:
                    fatalError()
                }
            },
            itemSubject: contentInsetsReferenceSubject
        )
    }
    
    private func makeResetAction() -> UIAction {
        UIAction(
            title: "Reset",
            image: UIImage(systemName: "arrow.counterclockwise"),
            handler: { [unowned self] _ in
                reset()
            }
        )
    }
}

private extension ViewModel {
    enum Constants {
        static let columnCount = 3
        static let spacing: CGFloat = 8
        static let contentInsetsReference = UIContentInsetsReference.automatic
    }
    
    static func makeItems() -> [ItemModel] {
        (0...999).map { .init(title: "Item \($0)")}
    }
}
