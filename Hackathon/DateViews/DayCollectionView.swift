//
//  DayCollectionView.swift
//  Hackathon
//
//  Created by Alan Li on 2018-10-06.
//  Copyright © 2018 James Ajhar. All rights reserved.
//

import UIKit

class DayCollectionViewLayout: UICollectionViewLayout {
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 60 * 7, height: 40)
    }
}

class DayCollectionView: UICollectionView {
    
    private let monToFriMap = [1: "Mon", 2: "Tues", 3: "Wed", 4: "Thurs", 5: "Fri", 6: "Sat", 7: "Sun"]
    
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

extension DayCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellText: String
        
        switch indexPath.row {
        case 0: cellText = "Today"
        case 1: cellText = "Tmrw"
        default:
            cellText = monToFriMap[((currentDateToNum() + indexPath.row - 1) % 7) + 1]!
        }
        
        return UICollectionViewCell()
    }
}

extension DayCollectionView {
    
    func currentDateToNum() -> Int {
        return Calendar.current.component(.weekday, from: Date())
    }
}
