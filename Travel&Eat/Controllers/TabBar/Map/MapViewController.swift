//
//  MapViewController.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: MasterTabBarSectionViewController {

    var locationManager = CLLocationManager()
    var restaurants = [Restaurant]()
    var currentMapLocation:CLLocationCoordinate2D?
    var currentUserLocation:CLLocationCoordinate2D?
    var annotations = [MKPointAnnotation]()
    
    lazy var mapView:MKMapView = {
        let map = MKMapView(frame: .zero)
        map.translatesAutoresizingMaskIntoConstraints = false
        map.delegate = self
        map.showsUserLocation = true
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
       
        return map
    }()
    
    lazy var searchThisAreaButton:UIButton = {
       let b = UIButton(frame: .zero)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Search this area", for: .normal)
        b.titleLabel?.font = UIFont(name: SFOFont.proTextMedium.rawValue, size: 20)
        b.addTarget(self, action: #selector(searchThisArea), for: .touchUpInside)
        b.backgroundColor = UIColor.tanHide
        b.layer.cornerRadius = 10
        return b
    
    }()
    
    @objc func searchThisArea() {
        if let currentMapLocation = currentMapLocation {
        let latitude = String(format: "%f", currentMapLocation.latitude)
        let longitude = String(format: "%f", currentMapLocation.longitude)
            mapView.removeAnnotations(self.annotations)
            
            APIManager().getRestaurants(latitude: latitude, longitude:  longitude) { (restaurants, error) in
                self.restaurants = restaurants
                for rest in restaurants {
                    let annotation = MKPointAnnotation()
                    annotation.title = rest.name
                    annotation.coordinate = CLLocationCoordinate2D(latitude: Double(rest.location.latitude)! , longitude: Double(rest.location.longitude)!)
                    
                    DispatchQueue.main.async {
                        self.mapView.addAnnotation(annotation)
                    }
                    self.annotations.append(annotation)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    override func setupView() {
        super.setupView()
        
        [mapView, searchThisAreaButton].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            
            searchThisAreaButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            searchThisAreaButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchThisAreaButton.widthAnchor.constraint(equalToConstant: 200),
            searchThisAreaButton.heightAnchor.constraint(equalToConstant: 30),
            ])
        
    }
    var animateView:MKAnnotationView = MKAnnotationView()
    var timer:Timer?
    var currentSize:CGSize = CGSize(width: 0, height: 0)
}

extension MapViewController:MKMapViewDelegate, CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways,.authorizedWhenInUse:
            break
        case .denied,.notDetermined,.restricted:
            break
        @unknown default:
            break
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.currentMapLocation = mapView.centerCoordinate
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier:annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        
        annotationView?.canShowCallout = true
        annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        let pinImage = UIImage(named: "pin")
        annotationView!.image = pinImage
        
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        self.currentUserLocation = userLocation.coordinate
    }
   
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        animateView = view
        currentSize = animateView.image!.size
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerFired), userInfo: animateView.image!.size, repeats: true)

        
    }
    
    @objc func timerFired() {
        let pinImage = UIImage(named: "pin")
        var newSize = CGSize(width: currentSize.width - 1, height: currentSize.height - 1)
        
        if (newSize.width <= 16 || newSize.height <= 16) {
            newSize = timer?.userInfo as! CGSize
        }
        animateView.image = resizeImage(image: pinImage!, targetSize: newSize)
        currentSize = newSize
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
        timer?.invalidate()
        animateView.image = UIImage(named: "pin")
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let title = view.annotation!.title {
            if let rest = restaurants.first(where: {$0.name == title}) {
                let v = RestaurantDetailViewController(restaurant: rest)
                self.navigationController?.show(v, sender: nil)
            }
        }
    }
    
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: (image.size.width - newSize.width)/2, y:  size.height - newSize.height, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions( size, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}


