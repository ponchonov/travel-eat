//
//  RestaurantDetailViewController.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var restaurant:Restaurant?
    
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
        b.setImage(UIImage(named: "start"), for: .normal)
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
    
    override func setupView() {
        super.setupView()
        [imageTop].forEach(view.addSubview)
            
        NSLayoutConstraint.activate([
            imageTop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageTop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageTop.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            imageTop.heightAnchor.constraint(equalToConstant: 300)
            ])
        
        if let url = URL(string: restaurant?.thumb ?? "") {
            imageTop.setImageWithURL(url: url )
        }
    }
    
}
