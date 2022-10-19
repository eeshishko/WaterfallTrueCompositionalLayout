//
//  ViewController.swift
//  WaterfallTrueCompositionalLayoutDemo
//
//  Created by Evgeny Shishko on 12.09.2022.
//

import UIKit
import Combine
import WaterfallTrueCompositionalLayout

final class ViewController: UICollectionViewController {
    private lazy var dataSource = makeDataSource()
    
    private let editButton = UIBarButtonItem(
        title: "Edit"
    )
    
    private var cancellables = Set<AnyCancellable>()
    
    private let viewModel = ViewModel()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Waterfall True Compositional"
        collectionView.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = editButton
        
        viewModel.layoutConfiguration.sink { [unowned self] configuration in
            let layout = UICollectionViewCompositionalLayout { sectionIndex, enviroment in
                WaterfallTrueCompositionalLayout.makeLayoutSection(
                    config: configuration,
                    enviroment: enviroment,
                    sectionIndex: sectionIndex
                )
            }
            collectionView.setCollectionViewLayout(layout, animated: true)
        }.store(in: &cancellables)
        
        viewModel.snapshot.sink { [unowned self] snapshot in
            dataSource.apply(snapshot)
        }.store(in: &cancellables)
        
        viewModel.menu.sink { [unowned self] menu in
            editButton.menu = menu
        }.store(in: &cancellables)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.removeItem(at: indexPath)
    }
    
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Int, ItemModel> {
        let registration = makeCellRegistration()
        return UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: item
            )
        }
    }
    
    private func makeCellRegistration() -> UICollectionView.CellRegistration<CollectionViewCell, ItemModel> {
        UICollectionView.CellRegistration { cell, _, item in
            cell.configure(with: item)
        }
    }
}

