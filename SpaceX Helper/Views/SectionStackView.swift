//
//  GeneralInfoStackView.swift
//  SpaceX Info
//
//  Created by Artem Kvashnin on 24.08.2022.
//

import UIKit

class SectionStackView: UIStackView {
    
    lazy var firstRowTitleLabel: UILabel = {
        return createTitleLabel()
    }()
    
    lazy var secondRowTitleLabel: UILabel = {
        return createTitleLabel()
    }()
    
    lazy var thirdRowTitleLabel: UILabel = {
        return createTitleLabel()
    }()
    
    lazy var firstRowInfoLabel: UILabel = {
        return createInfoLabel()
    }()
    
    lazy var secondRowInfoLabel: UILabel = {
        return createInfoLabel()
    }()
    
    lazy var thirdRowInfoLabel: UILabel = {
        return createInfoLabel()
    }()
    
    lazy var firstRowUnitLabel: UILabel = {
        createUnitLabel()
    }()
    lazy var secondRowUnitLabel: UILabel = {
        createUnitLabel()
    }()
    
    lazy var thirdRowUnitLabel: UILabel = {
        createUnitLabel()
    }()
    
    var unitLabelsAvailable: Bool = false {
        didSet {
            firstRowUnitLabelWidthConstraint?.constant = unitLabelWidth
            secondRowUnitLabelWidthConstraint?.constant = unitLabelWidth
            thirdRowUnitLabelWidthConstraint?.constant = unitLabelWidth

        }
    }
    
    private var firstRowUnitLabelWidthConstraint: NSLayoutConstraint?
    private var secondRowUnitLabelWidthConstraint: NSLayoutConstraint?
    private var thirdRowUnitLabelWidthConstraint: NSLayoutConstraint?

    private var unitLabelWidth: CGFloat {
        return unitLabelsAvailable ? 36 : 0
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        super .init(coder: coder)
        setupView()
    }
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16)
        label.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        label.textColor = UIColor(rgb: 0xcacaca)
        return label
    }



    private func createInfoLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16)
        label.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        label.textColor = UIColor(rgb: 0xf6f6f6)
        return label
    }
    
    private func createUnitLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16 , weight: .bold)
        label.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        label.textColor = UIColor(rgb: 0x8E8E8F)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func setupView() {
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillProportionally
        self.spacing = 16
        
        let titleLabelsList = [firstRowTitleLabel, secondRowTitleLabel, thirdRowTitleLabel]
        let infoLabelsList = [firstRowInfoLabel, secondRowInfoLabel, thirdRowInfoLabel]
        let unitLabelsList = [firstRowUnitLabel, secondRowUnitLabel, thirdRowUnitLabel]
        
        firstRowUnitLabelWidthConstraint = firstRowUnitLabel.widthAnchor.constraint(equalToConstant: unitLabelWidth)
        secondRowUnitLabelWidthConstraint = secondRowUnitLabel.widthAnchor.constraint(equalToConstant: unitLabelWidth)
        thirdRowUnitLabelWidthConstraint = thirdRowUnitLabel.widthAnchor.constraint(equalToConstant: unitLabelWidth)
        
        firstRowUnitLabelWidthConstraint?.isActive = true
        secondRowUnitLabelWidthConstraint?.isActive = true
        thirdRowUnitLabelWidthConstraint?.isActive = true

        
        for i in 0...2 {
            let hStack = UIStackView(arrangedSubviews: [titleLabelsList[i], infoLabelsList[i], unitLabelsList[i]])
            hStack.axis = .horizontal
            hStack.distribution = .fill
            hStack.alignment = .fill
            self.addArrangedSubview(hStack)
        }
    }

}
