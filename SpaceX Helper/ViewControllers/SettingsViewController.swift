//
//  SettingsTableViewController.swift
//  SpaceX Info
//
//  Created by Artem Kvashnin on 23.08.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func updateInfo()
}

class SettingsViewController: UIViewController {
    
    var delegate: SettingsViewControllerDelegate?
    
    var settings: Settings
    
    var settingsView: SettingsView! {
        guard isViewLoaded else { return nil }
        return (self.view as! SettingsView)
    }
    
    init(settings: Settings) {
        self.settings = settings
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        configureNavigationBar()
        settingsView.configureWithSettings(settings)
        
        settingsView.heightSegmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        settingsView.diameterSegmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        settingsView.massSegmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        settingsView.payloadSegmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }

    override func loadView() {
        let settingsView = SettingsView()
        self.view = settingsView
    }
    
    func configureNavigationBar() {
        self.navigationItem.title = "Settings"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xFFFFFF),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeButtonTapped))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xFFFFFF),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ], for: .normal)
    }

    @objc func closeButtonTapped() {
        self.dismiss(animated: true)
        delegate?.updateInfo()
        
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedSegmentIndex = sender.selectedSegmentIndex
        switch sender {
            case settingsView.heightSegmentedControl:
                settings.height = .allCases[selectedSegmentIndex]
            case settingsView.diameterSegmentedControl:
                settings.diameter = .allCases[selectedSegmentIndex]
            case settingsView.massSegmentedControl:
                settings.mass = .allCases[selectedSegmentIndex]
            case settingsView.payloadSegmentedControl:
                settings.payload = .allCases[selectedSegmentIndex]
            default:
                return
        }
    }
}
