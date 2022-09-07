//
//  RocketInfoBottomSheetView.swift
//  SpaceX Info
//
//  Created by Artem Kvashnin on 24.08.2022.
//

import UIKit

class RocketInfoView: UIView {
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setupView()
        
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0x000000)
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    private let wrapperView = UIView()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    let rocketNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.text = "Rocket"
        label.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        label.textColor = UIColor(rgb: 0xF6F6F6)
        return label
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("", for: .normal)
        let image = UIImage(named: "Setting")
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = .black
        collectionView.alwaysBounceVertical = false
        return collectionView
    }()
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 40
        return stack
    }()
    
    let launchInfoSection = LaunchInfoSectionView()
    
    let firstStageSection: StageSectionView = {
        let sectionView = StageSectionView()
        sectionView.stageTitleLabel.text = "First Stage"
        return sectionView
    }()
    
    let secondStageSection: StageSectionView = {
        let sectionView = StageSectionView()
        sectionView.stageTitleLabel.text = "Second Stage"
        return sectionView
    }()
    
    let launchScreenButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show launches", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .medium)
        button.backgroundColor = UIColor(rgb: 0x212121)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let spacerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let imageViewHeight = UIScreen.main.bounds.height * 0.4
    
    private var containerViewHalfSizedTopAnchorConstraint: NSLayoutConstraint?
    private var containerViewFullSizedTopAnchorConstraint: NSLayoutConstraint?
    
    private var containerViewIsFullSized: Bool = false
    
    
    private func setupView() {
        // Seting up container and image views
        self.addSubview(imageView)
        self.addSubview(containerView)
                
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageViewHeight),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        containerViewHalfSizedTopAnchorConstraint = containerView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -50)
        containerViewHalfSizedTopAnchorConstraint?.isActive = true
        
        containerViewFullSizedTopAnchorConstraint = containerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0)
        containerViewFullSizedTopAnchorConstraint?.isActive = false
        
        hStack.addArrangedSubview(rocketNameLabel)
        hStack.addArrangedSubview(settingsButton)
        containerView.addSubview(hStack)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        //Setting up scroll view
        containerView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(spacerView)
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 32),
            hStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32),
            hStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 48),
            scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 32),
            scrollView.bottomAnchor.constraint(equalTo: spacerView.topAnchor),
            
            spacerView.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor),
            spacerView.heightAnchor.constraint(equalToConstant: 50),
            spacerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            spacerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        //Add wrapper view to scroll view and setting up constraints
        scrollView.addSubview(wrapperView)
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            wrapperView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            wrapperView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            wrapperView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: 1)
        ])
        
        //Add views to wrapper view and setting up constraints
        
        vStack.addArrangedSubview(launchInfoSection)
        vStack.addArrangedSubview(firstStageSection)
        vStack.addArrangedSubview(secondStageSection)
        vStack.addArrangedSubview(launchScreenButton)
        
        wrapperView.addSubview(collectionView)
        wrapperView.addSubview(vStack)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false
        launchScreenButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 32),
            collectionView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            collectionView.widthAnchor.constraint(equalTo: collectionView.heightAnchor, multiplier: 3.5),
            vStack.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
            vStack.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 32),
            vStack.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor,constant: -32),
            vStack.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -16),
            launchScreenButton.heightAnchor.constraint(equalToConstant: 50)
        ])

    }
}

extension RocketInfoView {
    func setupSwipeGesture() {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(gesture:)))
        swipeGestureRecognizer.numberOfTouchesRequired = 1
        swipeGestureRecognizer.direction = .up
        self.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    @objc func handleSwipeGesture(gesture: UISwipeGestureRecognizer) {
        
        if containerViewIsFullSized {
            containerViewIsFullSized = false
            gesture.direction = .up
            UIView.animate(withDuration: 0.3) {
                self.containerViewFullSizedTopAnchorConstraint?.isActive = false
                self.containerViewHalfSizedTopAnchorConstraint?.isActive = true
                self.layoutIfNeeded()
            }
        } else {
            containerViewIsFullSized = true
            gesture.direction = .down
            UIView.animate(withDuration: 0.3) {
                self.containerViewHalfSizedTopAnchorConstraint?.isActive = false
                self.containerViewFullSizedTopAnchorConstraint?.isActive = true
                self.layoutIfNeeded()
            }
        }
    }
                                                              
}

//Updating  method with rocket info
extension RocketInfoView {
    func updateFor(_ rocket: Rocket) {
        rocketNameLabel.text = rocket.name
        launchInfoSection.updateFor(rocket)
        firstStageSection.updateFor(rocket.firstStage)
        secondStageSection.updateFor(rocket.secondStage)
    }
}
