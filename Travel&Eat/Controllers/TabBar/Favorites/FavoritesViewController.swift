//
//  FavoritesViewController.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import UIKit

class FavoritesViewController: MasterTabBarSectionViewController {

    lazy var emptyStateLabel:UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .lightGray
        l.numberOfLines = 4
        l.textAlignment = .center
        l.text = "You don't have\nfavorites yet\nfound a place and mark it\nwith a star."
        l.font = UIFont(name: SFOFont.proTextMedium.rawValue, size: 22)
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setupView() {
        super.setupView()
        
        [emptyStateLabel].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
    }

}
