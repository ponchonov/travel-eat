//
//  RestaurantDetailViewController.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import UIKit
import MapKit

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
    
    private lazy var directionsButton: UIButton = {
        let b = UIButton(frame: .zero)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        b.setTitle("Get directions", for: .normal)
        b.backgroundColor = UIColor.tanHide
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 10
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.black.cgColor
        return b
    }()
    
    private lazy var labelName: UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: SFOFont.proTextBold.rawValue, size: 20)
        l.numberOfLines = 0
        return l
    }()

    
    private lazy var labelAddress: UILabel = {
       let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: SFOFont.proTextRegular.rawValue, size: 17)
        l.numberOfLines = 0
        return l
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
    
    @objc func getDirections() {
        
        guard let restaurant = restaurant else {return}
        
        let latitude: CLLocationDegrees = Double(restaurant.location.latitude)!
        let longitude: CLLocationDegrees = Double(restaurant.location.longitude)!
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = restaurant.name
        mapItem.openInMaps(launchOptions: options)
       
    }
    
    override func setupView() {
        super.setupView()
        [imageTop, labelName, labelAddress, directionsButton, starButton].forEach(view.addSubview)
            
        NSLayoutConstraint.activate([
            imageTop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageTop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageTop.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            imageTop.heightAnchor.constraint(equalToConstant: 300),
            
            starButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            starButton.topAnchor.constraint(equalTo: imageTop.bottomAnchor, constant: 10),
            starButton.widthAnchor.constraint(equalToConstant: 45),
            starButton.heightAnchor.constraint(equalToConstant: 45),
            
            labelName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            labelName.trailingAnchor.constraint(equalTo: starButton.leadingAnchor, constant: -8),
            labelName.topAnchor.constraint(equalTo: imageTop.bottomAnchor, constant: 8),
            
            labelAddress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            labelAddress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            labelAddress.topAnchor.constraint(equalTo: starButton.bottomAnchor),
            
            directionsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            directionsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            directionsButton.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 26),
            directionsButton.heightAnchor.constraint(equalToConstant: 40),
            
            ])
        
        guard let restaurant = restaurant else {return}
        if let url = URL(string: restaurant.thumb) {
            imageTop.setImageWithURL(url: url )
        }
        labelAddress.text = restaurant.location.address
        labelName.text = restaurant.name
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
