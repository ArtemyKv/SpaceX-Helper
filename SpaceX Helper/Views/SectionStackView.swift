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
    
    private func setupView() {
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillProportionally
        self.spacing = 16
        
        let titleLabelsList = [firstRowTitleLabel, secondRowTitleLabel, thirdRowTitleLabel]
        let infoLabelsList = [firstRowInfoLabel, secondRowInfoLabel, thirdRowInfoLabel]
        
        for i in 0...2 {
            let hStack = UIStackView(arrangedSubviews: [titleLabelsList[i], infoLabelsList[i]])
            hStack.axis = .horizontal
            hStack.distribution = .fill
            hStack.alignment = .fill
            self.addArrangedSubview(hStack)
        }
    }

}
