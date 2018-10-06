//
//  ViewController.swift
//  Hackathon
//
//  Created by James Ajhar on 10/4/18.
//  Copyright © 2018 James Ajhar. All rights reserved.
//

import UIKit

private let buttonBubbleHeight = 66

class StartViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "easy meet"
        titleLabel.font = UIFont(name: "ArialRoundedMTBold", size: 36)
        titleLabel.textColor = .white
        return titleLabel
    }
    
    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "casual scheduling. made easy."
        descriptionLabel.font = UIFont(name: "Avenir-Book", size: 20)
        descriptionLabel.textColor = .white
        return titleLabel
    }
    
    let hasAccountButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("I have an account", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14)
        button.titleLabel?.textColor = .white
        return button
    }()

    let textLoginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("text me my login link", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 20)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = buttonBubbleHeight / 2
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
}

// MARK: - View Setup
extension StartViewController {
    
    func setupViews() {
        view.backgroundColor = UIColor(hexString: "1199EE")
        view.addSubview(hasAccountButton)
        view.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            textLoginButton.heightAnchor.constraint(equalToConstant: buttonBubbleHeight),
            
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hasAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
















