//
//  RestaurantsViewController.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import UIKit

class RestaurantsViewController: ViewController {

    var collection:Collection
    
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
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(frame: .zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.hidesWhenStopped = true
        v.style = UIActivityIndicatorView.Style.gray
        v.isHidden = true
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Restaurants"
        DispatchQueue.main.async {
            self.loadingIndicator.isHidden = false
            self.loadingIndicator.startAnimating()
        }
        APIManager().getRestaurants(collectionId: self.collection.collection_id, completion: { (restaurants, error) in
            DispatchQueue.main.async {
                self.restaurants = restaurants
                self.collectionView.reloadData()
                self.loadingIndicator.stopAnimating()
                
                if restaurants.count == 0 {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        })
    }


    init(collection:Collection) {
        self.collection = collection
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        super.setupView()
        collectionView.addToViewAndAddFullConstrainst(for: self.view)
        [loadingIndicator].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
    }
}


extension RestaurantsViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! CollectionRestaurantViewCell
        cell.restaurant = self.restaurants[indexPath.row]
        return cell
    }
    
}
