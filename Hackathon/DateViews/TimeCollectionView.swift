//
//  TimeCollectionView.swift
//  Hackathon
//
//  Created by Alan Li on 2018-10-06.
//  Copyright © 2018 James Ajhar. All rights reserved.
//

import UIKit

class TimeCollectionView: UICollectionView {
    
    init() {
        super.init(frame: .zero, collectionViewLayout: DayCollectionViewLayout())
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: "\(DayCollectionView.self)")
        dataSource = self
        backgroundColor = .orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class TimeCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let time = Calendar.current.date(bySettingHour: 7 + indexPath.item, minute: 0, second: 0, of: Date())
        let hours = Calendar.current.component(.hour, from: time!)
        
        
    }
}
