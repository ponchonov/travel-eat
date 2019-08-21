//
//  CityTableViewCell.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    var city:City? {
        didSet {
            setupView()
        }
    }
    
    private lazy var backView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .tanHide
        return view
    }()
    
    private lazy var nameCityLabel:UILabel = {
       let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.text = "City:"
        l.font = UIFont(name: SFOFont.proTextMedium.rawValue, size: 16)
        l.textAlignment = .right
        
        return l
    }()
    
    private lazy var nameStateLabel:UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.text = "State:"
        l.font = UIFont(name: SFOFont.proTextMedium.rawValue, size: 16)
        l.textAlignment = .right

        return l
    }()
    
    private lazy var nameCountryLabel:UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.text = "Country:"
        l.font = UIFont(name: SFOFont.proTextMedium.rawValue, size: 16)
        return l
    }()
    
    private lazy var nameCity:UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .black
        l.font = UIFont(name: SFOFont.proTextRegular.rawValue, size: 16)
        return l
    }()
    
    private lazy var nameState:UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .black
        l.font = UIFont(name: SFOFont.proTextRegular.rawValue, size: 16)
        return l
    }()
    
    private lazy var nameCountry:UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .black
        l.font = UIFont(name: SFOFont.proTextRegular.rawValue, size: 16)
        l.textAlignment = .right

        return l
    }()
    
    private lazy var flagCountry: UIImageView = {
       let f = UIImageView(frame: .zero)
        f.translatesAutoresizingMaskIntoConstraints = false
        f.contentMode = UIView.ContentMode.scaleAspectFit
        return f
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView()  {
        guard let city = city else {return}
        
        [backView, nameCityLabel, nameStateLabel, nameCountryLabel, nameCity, nameState, nameCountry, flagCountry].forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
                backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                
                nameCityLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
                nameCityLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8),
                nameCityLabel.widthAnchor.constraint(equalToConstant: 50),
                
                nameStateLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
                nameStateLabel.topAnchor.constraint(equalTo: nameCityLabel.bottomAnchor, constant: 5),
                nameStateLabel.widthAnchor.constraint(equalToConstant: 50),
                nameStateLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -15),

                nameCity.leadingAnchor.constraint(equalTo: nameCityLabel.trailingAnchor),
                nameCity.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8),
                nameCity.trailingAnchor.constraint(equalTo: nameCountryLabel.leadingAnchor),
                
                nameState.leadingAnchor.constraint(equalTo: nameStateLabel.trailingAnchor),
                nameState.centerYAnchor.constraint(equalTo: nameStateLabel.centerYAnchor),
                nameState.trailingAnchor.constraint(equalTo: nameCountryLabel.leadingAnchor),
                
                nameCountryLabel.trailingAnchor.constraint(equalTo: flagCountry.leadingAnchor),
                nameCountryLabel.widthAnchor.constraint(equalToConstant: 70),
                nameCountryLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
                
                nameCountry.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -8),
                nameCountry.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -8),
                
                flagCountry.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -8),
                flagCountry.topAnchor.constraint(equalTo: backView.topAnchor, constant: 4),
                flagCountry.widthAnchor.constraint(equalToConstant: 20),
                flagCountry.heightAnchor.constraint(equalToConstant: 20),


                
            ])
        
        nameCity.text = city.name
        nameState.text = city.state_name ?? ""
        nameCountry.text = city.country_name ?? ""
        
        if let url = URL(string: city.country_flag_url ?? "") {
            flagCountry.setImageWithURL(url: url)
        }
        
    }

}
