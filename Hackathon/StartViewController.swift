//
//  ViewController.swift
//  Hackathon
//
//  Created by James Ajhar on 10/4/18.
//  Copyright © 2018 James Ajhar. All rights reserved.
//

import UIKit
import SDWebImage

private let buttonBubbleHeight: CGFloat = 66

class StartViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "easy meet"
        titleLabel.font = UIFont(name: "ArialRoundedMTBold", size: 36)
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "casual scheduling. made easy."
        descriptionLabel.font = UIFont(name: "Avenir-Book", size: 20)
        descriptionLabel.textColor = .white
        return descriptionLabel
    }()
    
    let hasAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("I have an account", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    let textLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("text me my login link", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 20)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = buttonBubbleHeight / 2
        return button
    }()
    
    let welcomeGifDisplayer: UIImageView = {
        let imageData = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "welcome-gif", ofType: "gif")!))
        let imageView = UIImageView(image: UIImage.sd_animatedGIF(with: imageData))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
}

// MARK: - Actions
extension StartViewController {
    
    @objc func navigationTest() {
        let navigationController = UINavigationController(rootViewController: RootTabBarController(nibName: nil, bundle: nil))
        navigationController.navigationBar.barTintColor = UIColor.easyMeetTheme
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont(name: "ArialRoundedMTBold", size: 24)!
        ]
        present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - View Setup
extension StartViewController {
    
    func setupViews() {
        view.backgroundColor = UIColor.easyMeetTheme
        view.addSubview(hasAccountButton)
        view.addSubview(titleLabel)
        view.addSubview(welcomeGifDisplayer)
        view.addSubview(textLoginButton)
        view.addSubview(descriptionLabel)
        view.addSubview(hasAccountButton)
        
        textLoginButton.addTarget(self, action: #selector(navigationTest), for: .touchUpInside)
    }
    
    func setupConstraints() {
        let defaultSpacing: CGFloat = 16.0
        
        let highPriorityConstraints = [
            welcomeGifDisplayer.widthAnchor.constraint(equalTo: welcomeGifDisplayer.heightAnchor)
        ]
        highPriorityConstraints.forEach { $0.priority = UILayoutPriority(rawValue: 999) }
        
        NSLayoutConstraint.activate([
            textLoginButton.heightAnchor.constraint(equalToConstant: buttonBubbleHeight),
            
            welcomeGifDisplayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeGifDisplayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hasAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            welcomeGifDisplayer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: defaultSpacing),
            descriptionLabel.topAnchor.constraint(equalTo: welcomeGifDisplayer.bottomAnchor, constant: defaultSpacing * 2),
            
            hasAccountButton.topAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: defaultSpacing * 2),
            
            hasAccountButton.bottomAnchor.constraint(lessThanOrEqualTo: textLoginButton.topAnchor, constant: defaultSpacing),
            textLoginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        + highPriorityConstraints
        )
    }
}
















