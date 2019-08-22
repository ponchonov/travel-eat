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
    
    lazy var searchViewEmpty:UIImageView = {
        let l = UIImageView(frame: .zero)
        l.image = UIImage(named: "search")
        l.translatesAutoresizingMaskIntoConstraints = false
        
        return l
    }()
    
    lazy var tableView: UITableView = {
       let t = UITableView(frame: .zero)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.delegate = self
        t.dataSource = self
        t.register(CityTableViewCell.self, forCellReuseIdentifier: "city")
        t.separatorColor = .clear
        t.isHidden = true
        t.rowHeight = UITableView.automaticDimension

        return t
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(frame: .zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.hidesWhenStopped = true
        v.style = UIActivityIndicatorView.Style.gray
        v.isHidden = true
        return v
    }()
    
    var cities:[City] = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        searchBar.placeholder = "Try with New York"

    }
    
    override func setupView() {
        super.setupView()
        
        [searchViewEmpty, labelSearch].forEach(view.addSubview)
        tableView.addToViewAndAddFullConstrainst(for: view)
        [loadingIndicator].forEach(view.addSubview)

        NSLayoutConstraint.activate([
                labelSearch.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
                labelSearch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                searchViewEmpty.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                searchViewEmpty.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                
                loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
    }
    
    @objc func viewTapped() {
        searchBar.resignFirstResponder()
        
    }
    
    override func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    override func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
            self.tableView.isHidden  = false
            self.loadingIndicator.isHidden = false
            self.loadingIndicator.startAnimating()
        }
        APIManager().getSearchResult(search: text) { (cities, error) in
            DispatchQueue.main.async {
                self.cities = cities
                self.tableView.reloadData()
                self.loadingIndicator.stopAnimating()
                
                if cities.count == 0 {
                    self.tableView.isHidden  = true
                    self.labelSearch.text = "No search results with \(text)\nplease try again."
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.cities = []
            self.tableView.reloadData()
            self.tableView.isHidden  = true

        }
    }

}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "city") as! CityTableViewCell
        cell.city = cities[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let v = CitySelectedViewController(city: cities[indexPath.row])
        
        self.show(v, sender: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewTapped()
    }
}
