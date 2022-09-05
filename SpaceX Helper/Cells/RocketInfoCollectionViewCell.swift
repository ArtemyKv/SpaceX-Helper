//
//  RocketInfoCollectionViewCell.swift
//  SpaceX Info
//
//  Created by Artem Kvashnin on 31.08.2022.
//

import UIKit

class RocketInfoCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "RocketInfoCollectionViewCell"
    
    let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.contentMode = .center
        label.textColor = UIColor(rgb: 0xFFFFFF)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(rgb: 0x8E8E8F)
        label.contentMode = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setupCell()
    }
    
    
    func setupCell() {
        vStack.addArrangedSubview(valueLabel)
        vStack.addArrangedSubview(descriptionLabel)
        self.contentView.addSubview(vStack)
        
        self.backgroundColor = UIColor(rgb: 0x212121)
        self.layer.cornerRadius = 32
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
