//
//  RocketInfoViewController.swift
//  SpaceX Info
//
//  Created by Artem Kvashnin on 23.08.2022.
//

import UIKit

class SingleRocketInfoViewController: UIViewController {
    
    typealias DataSourceType = UICollectionViewDiffableDataSource<Section, Item>
    
    var rocket: Rocket!
    
    var settings = Settings()
    
    var downloadService: DownloadService!
    
    var collectionViewDataSource: DataSourceType!
    
    enum Section {
        case main
    }
    
    enum Item: Hashable {
        case height(Length)
        case diameter(Length)
        case mass(Mass)
        case payload(Payload)
    }
    
    var rocketInfoView: RocketInfoView! {
        guard isViewLoaded else { return nil }
        return (self.view as! RocketInfoView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rocketInfoView.setupSwipeGesture()
        rocketInfoView.settingsButton.addTarget(self, action: #selector(settingsButtonTapped(_:)), for: .touchUpInside)
        rocketInfoView.launchScreenButton.addTarget(self, action: #selector(showLaunchesButtonTapped(_:)), for: .touchUpInside)
        
        rocketInfoView.collectionView.register(RocketInfoCollectionViewCell.self, forCellWithReuseIdentifier: RocketInfoCollectionViewCell.reuseIdentifier)
        collectionViewDataSource = createCollectionViewDataSource()
        rocketInfoView.collectionView.dataSource = collectionViewDataSource
        rocketInfoView.collectionView.collectionViewLayout = createCollectionViewLayout()
        
        setupView(rocket: rocket)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func loadView() {
        let rocketInfoView = RocketInfoView()
        self.view = rocketInfoView
    }
    
    func setupView(rocket: Rocket) {
        rocketInfoView.updateFor(rocket)
        applySnapshot()
    }
    
    func createCollectionViewDataSource() -> DataSourceType {
        let dataSource = DataSourceType(collectionView: rocketInfoView.collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketInfoCollectionViewCell.reuseIdentifier, for: indexPath) as! RocketInfoCollectionViewCell
            
            switch itemIdentifier {
                case .height(let height):
                    cell.descriptionLabel.text = "Height, \(self.settings.height.rawValue)"
                    cell.valueLabel.text = self.settings.height == .m ? "\(height.meters)" : "\(height.feet)"
                case .diameter(let diameter):
                    cell.descriptionLabel.text = "Diameter, \(self.settings.diameter.rawValue)"
                    cell.valueLabel.text = self.settings.diameter == .m ? "\(diameter.meters)" : "\(diameter.feet)"
                case .mass(let mass):
                    cell.descriptionLabel.text = "Mass, \(self.settings.mass.rawValue)"
                    cell.valueLabel.text = self.settings.mass == .kg ? "\(mass.kg)" : "\(mass.lb)"
                case.payload(let payload):
                    cell.descriptionLabel.text = "Payload, \(self.settings.payload.rawValue)"
                    cell.valueLabel.text = self.settings.payload == .kg ? "\(payload.kg)" : "\(payload.lb)"
            }
            return cell
        }
        return dataSource
    }
    
    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
        
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems([
            .height(rocket.height),
            .diameter(rocket.diameter),
            .mass(rocket.mass),
            .payload((rocket.payloads.first { $0.id == "leo" })!)
        ])
        collectionViewDataSource.apply(snapshot)
    }
    
    @objc func settingsButtonTapped(_ sender: UIButton) {
        let settingsVC = SettingsViewController(settings: settings)
        settingsVC.delegate = self
        let navigationVC = UINavigationController(rootViewController: settingsVC)
        self.present(navigationVC, animated: true)
    }
    
    @objc func showLaunchesButtonTapped(_ sender: UIButton) {
        print("Hello!")
        let launchesVC = LaunchesTableViewController(rocketID: rocket.id, rocketName: rocket.name)
        launchesVC.downloadService = downloadService
        self.navigationController?.pushViewController(launchesVC, animated: true)
    }
}

extension SingleRocketInfoViewController: SettingsViewControllerDelegate {
    func updateInfo() {
        rocketInfoView.collectionView.reloadData()
    }
}
    


