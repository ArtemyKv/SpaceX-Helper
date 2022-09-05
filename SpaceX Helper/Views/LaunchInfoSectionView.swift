//
//  LaunchInfoSectionView.swift
//  SpaceX Info
//
//  Created by Artem Kvashnin on 24.08.2022.
//

import UIKit

class LaunchInfoSectionView: UIView {

    lazy var firstlaunchLabel = sectionStackView.firstRowInfoLabel
    lazy var countryLabel = sectionStackView.secondRowInfoLabel
    lazy var launchCostLabel = sectionStackView.thirdRowInfoLabel

    private let sectionStackView = SectionStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    private func setupView() {
        self.addSubview(sectionStackView)
        
        sectionStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sectionStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sectionStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sectionStackView.topAnchor.constraint(equalTo: self.topAnchor),
            sectionStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        sectionStackView.firstRowTitleLabel.text = "First Launch"
        sectionStackView.secondRowTitleLabel.text = "Country"
        sectionStackView.thirdRowTitleLabel.text = "Launch Cost"
        
    }

}

extension LaunchInfoSectionView {
    func updateFor(_ rocket: Rocket) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        firstlaunchLabel.text = dateFormatter.string(from: rocket.firstFlightDate)
        countryLabel.text = rocket.country
        launchCostLabel.text = rocket.costPerLaunch.formatted(.currency(code: "USD"))
    }
}
