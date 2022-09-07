//
//  StageStackView.swift
//  SpaceX Info
//
//  Created by Artem Kvashnin on 24.08.2022.
//

import UIKit

class StageSectionView: UIView {
    
    lazy var enginesCountLabel = sectionStackView.firstRowInfoLabel
    lazy var fuelAmountLabel = sectionStackView.secondRowInfoLabel
    lazy var burnTimeLabel = sectionStackView.thirdRowInfoLabel

    let sectionStackView: SectionStackView = {
        let sectionStackView = SectionStackView()
        
        sectionStackView.unitLabelsAvailable = true
        
        sectionStackView.firstRowTitleLabel.text = "Engines Count"
        sectionStackView.secondRowTitleLabel.text = "Fuel Amount"
        sectionStackView.thirdRowTitleLabel.text = "Burn Time"
        
        sectionStackView.secondRowUnitLabel.text = "ton"
        sectionStackView.thirdRowUnitLabel.text = "sec"
        
        return sectionStackView
    }()
    
    let stageTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .title1)
        label.textColor = UIColor(rgb: 0xF6F6F6)
        return label
    }()
    
    let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 16
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        vStack.addArrangedSubview(stageTitleLabel)
        vStack.addArrangedSubview(sectionStackView)
        self.addSubview(vStack)
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            vStack.topAnchor.constraint(equalTo: self.topAnchor),
            vStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}

extension StageSectionView {
    func updateFor(_ stage: Stage) {
        enginesCountLabel.text = "\(stage.enginesCount)"
        fuelAmountLabel.text = "\(stage.fuelAmount)"
        burnTimeLabel.text = stage.burnTime != nil ? "\(stage.burnTime!)" : "No burn time"
    }
}
