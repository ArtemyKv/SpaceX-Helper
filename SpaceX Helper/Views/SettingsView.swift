//
//  SettingsView.swift
//  SpaceX Info
//
//  Created by Artem Kvashnin on 31.08.2022.
//

import UIKit

class SettingsView: UIView {
    
    private let lengthUnitNamesList = Settings.Length.allCases.map { $0.rawValue }
    private let massUnitNamesList = Settings.Mass.allCases.map { $0.rawValue }
    private let settingNames = ["Height", "Diameter", "Mass", "Payload"]
    
    lazy var heightSegmentedControl: UISegmentedControl = createSegmentedControl(with: lengthUnitNamesList)
    
    lazy var diameterSegmentedControl: UISegmentedControl = createSegmentedControl(with: lengthUnitNamesList)
    
    lazy var massSegmentedControl: UISegmentedControl = createSegmentedControl(with: massUnitNamesList)
    
    lazy var payloadSegmentedControl: UISegmentedControl = createSegmentedControl(with: massUnitNamesList)
    
    let containerStackView: UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .fill
        vStack.spacing = 24
        return vStack
    }()

    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setupView()
    }
    
    private func createSegmentedControl(with items: [String]) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.backgroundColor = UIColor(rgb: 0x212121)
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x8E8E8F),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)
        ], for: .normal)
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x121212),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)
        ], for: .selected)
        segmentedControl.contentMode = .center
        segmentedControl.apportionsSegmentWidthsByContent = false
        return segmentedControl
    }
    
    private func settingNameLabelWith(name: String) -> UILabel {
        let label = UILabel()
        label.text = name
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(rgb: 0xF6F6F6)
        label.textAlignment = .left
        label.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        return label
    }
    
    private func setupView() {
        let segmentedControlList = [heightSegmentedControl, diameterSegmentedControl, massSegmentedControl, payloadSegmentedControl]
        for (index, name) in settingNames.enumerated() {
            let nameLabel = settingNameLabelWith(name: name)
            let segmentedControl = segmentedControlList[index]
            segmentedControl.translatesAutoresizingMaskIntoConstraints = false
            segmentedControl.widthAnchor.constraint(equalToConstant: 115).isActive = true
            segmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            let hStack = UIStackView(arrangedSubviews: [nameLabel, segmentedControl])
            hStack.distribution = .fill
            hStack.alignment = .fill
            containerStackView.addArrangedSubview(hStack)
        }
        
        self.addSubview(containerStackView)
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 56),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 28),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -28)
        ])
    }
    
    func configureWithSettings(_ settings: Settings) {
        
        heightSegmentedControl.selectedSegmentIndex = settings.height == .m ? 0 : 1
        diameterSegmentedControl.selectedSegmentIndex = settings.diameter == .m ? 0 : 1
        massSegmentedControl.selectedSegmentIndex = settings.mass == .kg ? 0 : 1
        payloadSegmentedControl.selectedSegmentIndex = settings.payload == .kg ? 0 : 1
    }
}
