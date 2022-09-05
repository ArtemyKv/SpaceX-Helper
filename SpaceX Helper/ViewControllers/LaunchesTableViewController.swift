//
//  LaunchesTableViewController.swift
//  SpaceX Info
//
//  Created by Artem Kvashnin on 23.08.2022.
//

import UIKit

class LaunchesTableViewController: UITableViewController {
    
    var rocketID: String
    var rocketName: String
    var launches: [Launch] = []
    
    var downloadService: DownloadService?
    
    init(rocketID: String, rocketName: String) {
        self.rocketID = rocketID
        self.rocketName = rocketName
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        configureNavigationBar()
        
        tableView.allowsSelection = false
        tableView.bounces = false
        tableView.register(LaunchTableViewCell.self, forCellReuseIdentifier: LaunchTableViewCell.reuseIdentifier)
        
        downloadService?.fetchLaunchesInfoForRocket(rocketID: rocketID, completion: { launches in
            self.launches = launches
            print(launches)
            self.tableView.reloadData()
        })

    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchTableViewCell.reuseIdentifier, for: indexPath) as! LaunchTableViewCell
        let launch = launches[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        
        cell.nameLabel.text = launch.name
        cell.dateLabel.text = dateFormatter.string(from: launch.date)
        cell.successImageView.image = launch.success ? UIImage(named: "Launch success") : UIImage(named: "Launch failure")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (UIScreen.main.bounds.width * 0.27)
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let newBackButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        newBackButtonItem.tintColor = .white
        newBackButtonItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium)], for: .normal)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = newBackButtonItem
        navigationItem.title = rocketName
    }

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
