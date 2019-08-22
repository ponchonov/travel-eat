//
//  RestaurantDetailViewController.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: ViewController {

    var liked = false
    var restaurant:Restaurant?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    private lazy var imageTop: UIImageView = {
        let f = UIImageView(frame: .zero)
        f.translatesAutoresizingMaskIntoConstraints = false
        f.contentMode = UIView.ContentMode.scaleAspectFill
        f.layer.masksToBounds = true
        return f
    }()
    
    private lazy var starButton: UIButton = {
        let b = UIButton(frame: .zero)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "favorite_filled"), for: .normal)
        b.addTarget(self, action: #selector(markAsFavorite), for: .touchUpInside)
        return b
    }()

    init(restaurant:Restaurant) {
        self.restaurant = restaurant
        super.init()
        self.title = restaurant.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func markAsFavorite() {
        
        DefaultsData().markAsFavorite(restaurant: self.restaurant!, favorite: !liked)
        updateStarButton()
    }
    
    override func setupView() {
        super.setupView()
        [imageTop, starButton].forEach(view.addSubview)
            
        NSLayoutConstraint.activate([
            imageTop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageTop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageTop.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            imageTop.heightAnchor.constraint(equalToConstant: 300),
            
            starButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            starButton.topAnchor.constraint(equalTo: imageTop.bottomAnchor, constant: 10),
            ])
        
        if let url = URL(string: restaurant?.thumb ?? "") {
            imageTop.setImageWithURL(url: url )
        }
        
       updateStarButton()
    }
    
    func updateStarButton()  {
        let restaurants = DefaultsData().getFavorites()

        liked = restaurants.contains(where: {$0.id == self.restaurant?.id})
        if liked {
            starButton.setImage(UIImage(named: "favorite_filled"), for: .normal)
        } else {
            starButton.setImage(UIImage(named: "favorite_empty"), for: .normal)
        }
    }
    
}
