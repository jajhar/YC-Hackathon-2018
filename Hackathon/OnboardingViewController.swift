//
//  OnboardingViewController.swift
//  Hackathon
//
//  Created by Alan Li on 2018-10-06.
//  Copyright © 2018 James Ajhar. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = view.backgroundColor
        tabBarController?.tabBar.barTintColor = view.backgroundColor
    }
}

