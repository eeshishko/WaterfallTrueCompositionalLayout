//
//  CollectionViewCell.swift
//  WaterfallTrueCompositionalLayoutDemo
//
//  Created by Evgeny Shishko on 19.09.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.defaultHigh + 2, for: .vertical)
        return label
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "water_image")
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: ItemModel) {
        textLabel.text = item.title
        contentView.backgroundColor = item.color
    }
    
    private func setUp() {
        contentView.addSubview(textLabel)
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -8),
            {
                let constraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5)
                constraint.priority = .defaultHigh + 1
                return constraint
            }(),
            
            textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
