//
//  ProfileTabsCollectionReusableView.swift
//  BuyFi
//
//  Created by XCodeClub on 2021-10-16.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {
       static let identifier = "ProfileTabsCollectionReusableView"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
