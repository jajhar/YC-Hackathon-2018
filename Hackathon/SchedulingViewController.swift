//
//  SchedulingViewController.swift
//  Hackathon
//
//  Created by Alan Li on 2018-10-06.
//  Copyright © 2018 James Ajhar. All rights reserved.
//

import UIKit

class SchedulingViewController: UIViewController {
    
    let dayCollectionView = DayCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(dayCollectionView)
        
        setupConstraints()
    }
}

extension SchedulingViewController {
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dayCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dayCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dayCollectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
