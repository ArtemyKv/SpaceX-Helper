//
//  LaunchTableViewCell.swift
//  SpaceX Info
//
//  Created by Artem Kvashnin on 02.09.2022.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "LaunchTableViewCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0x212121)
        view.layer.cornerRadius = 24
        return view
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor(rgb: 0xffffff)
        label.contentMode = .left
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(rgb: 0x8E8E8F)
        label.contentMode = .left
        return label
    }()
    
    let successImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setupView()
    }
    
    
    
    private func setupView() {
        self.backgroundColor = .black
        self.contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
        ])
        
        vStack.addArrangedSubview(nameLabel)
        vStack.addArrangedSubview(dateLabel)
        hStack.addArrangedSubview(vStack)
        hStack.addArrangedSubview(successImageView)
        
        containerView.addSubview(hStack)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        successImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            hStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32),
            hStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            successImageView.widthAnchor.constraint(equalToConstant: 32),
            successImageView.heightAnchor.constraint(equalTo: successImageView.widthAnchor, multiplier: 1)
        ])
    }

}
