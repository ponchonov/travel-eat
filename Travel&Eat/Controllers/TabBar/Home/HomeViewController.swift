//
//  HomeViewController.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import UIKit

class HomeViewController: MasterTabBarSectionViewController {

    lazy var labelSearch:UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .lightGray
        l.numberOfLines = 2
        l.textAlignment = .center
        l.text = "Here you will see\nthe search result."
        l.font = UIFont(name: SFOFont.proTextMedium.rawValue, size: 22)
        
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
       
    }
    
    override func setupView() {
        super.setupView()
        
        [labelSearch].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
                labelSearch.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                labelSearch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
    }
    
    override func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    override func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        APIManager().getSearchResult(search: text) { (cities, error) in
            print(cities)
        }
    }

}
