//
//  MasterTabBarSectionViewController.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import UIKit

class MasterTabBarSectionViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    lazy var searchBar:UISearchBar = {
        return(UISearchBar(frame: CGRect(x:0, y:0, width: 200, height: 20)))
    }()
    
    override func setupView() {
        super.setupView()
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
}

extension MasterTabBarSectionViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
