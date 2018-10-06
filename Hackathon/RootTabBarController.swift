//
//  RootTabBarController.swift
//  Hackathon
//
//  Created by Alan Li on 2018-10-05.
//  Copyright © 2018 James Ajhar. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = UIColor.easyMeetTheme
        let onboardingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "onboarding-view-controller")
        onboardingVC.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "when-image"), selectedImage: nil)
        setViewControllers([onboardingVC], animated: false)
    }
}

