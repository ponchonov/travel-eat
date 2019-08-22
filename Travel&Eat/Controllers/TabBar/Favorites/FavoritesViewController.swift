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
    
    
    override func setupView() {
        super.setupView()
        
        [emptyStateLabel].forEach(view.addSubview)
        
        collectionView.addToViewAndAddFullConstrainst(for: self.view)
        
        NSLayoutConstraint.activate([
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ])
    }
    var restaurants = [Restaurant]()
    
    lazy var collectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize(width: 165, height: 160)
        l.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let c = UICollectionView(frame: .zero, collectionViewLayout: l)
        c.register(CollectionRestaurantViewCell.self, forCellWithReuseIdentifier: "collection")
        c.translatesAutoresizingMaskIntoConstraints = false
        c.dataSource = self
        c.delegate = self
        c.backgroundColor = .white
        return c
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Restaurants"
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.restaurants = DefaultsData().getFavorites()
        self.collectionView.reloadData()
    }
}


extension FavoritesViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        collectionView.isHidden = restaurants.count == 0
        return restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! CollectionRestaurantViewCell
        cell.restaurant = self.restaurants[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let v = RestaurantDetailViewController(restaurant: restaurants[indexPath.row])
        self.navigationController?.show(v, sender: nil)
    }
    
}
