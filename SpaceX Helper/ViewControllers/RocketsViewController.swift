//
//  RocketsViewController.swift
//  SpaceX Info
//
//  Created by Artem Kvashnin on 29.08.2022.
//

import UIKit

class RocketsViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var pageController: UIPageViewController!
    
    var pageControl = UIPageControl()

    var singleRocketViewControllers: [SingleRocketInfoViewController] = []
    
    var rockets: [Rocket] = []
    
    let downloadService = DownloadService()

    override func viewDidLoad() {
        super.viewDidLoad()

        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageController.dataSource = self
        pageController.delegate = self

        self.addChild(pageController)
        view.addSubview(pageController.view)
        view.addSubview(pageControl)
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            pageController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            pageController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pageController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            pageControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        downloadService.fetchRocketInfo { rockets in
            self.rockets = rockets
            self.createPages(with: rockets)
            self.configurePageControl(with: rockets)
        }

    }
    
    func createPages(with rockets: [Rocket]) {
        for (_, rocket) in rockets.enumerated() {
            let rocketVC = SingleRocketInfoViewController()
            rocketVC.rocket = rocket
            rocketVC.downloadService = downloadService
            singleRocketViewControllers.append(rocketVC)
        }
        pageController.setViewControllers([singleRocketViewControllers[0]], direction: .forward, animated: false)
    }
    
    func configurePageControl(with rockets: [Rocket]) {
        pageControl.numberOfPages = rockets.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor(rgb: 0x121212)
        pageControl.pageIndicatorTintColor = UIColor(rgb: 0x8E8E8F)
        pageControl.currentPageIndicatorTintColor = UIColor(rgb: 0xFFFFFF)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = singleRocketViewControllers.firstIndex(of: viewController as! SingleRocketInfoViewController) else { return nil }
        
        if index > 0 {
            return singleRocketViewControllers[index - 1]
        } else {
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = singleRocketViewControllers.firstIndex(of: viewController as! SingleRocketInfoViewController) else { return nil }

        if index < singleRocketViewControllers.count - 1 {
            return singleRocketViewControllers[index + 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentVC = pageViewController.viewControllers![0]
        pageControl.currentPage = singleRocketViewControllers.firstIndex(of: currentVC as! SingleRocketInfoViewController)!
    }
}
