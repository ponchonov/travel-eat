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
    
    lazy var backView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .tanHide
        return view
    }()
    
    lazy var nameCityLabel:UILabel = {
       let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.font = UIFont(name: SFOFont.proTextRegular.rawValue, size: 17)
        
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView()  {
        guard let city = city else {return}
        
        [backView, nameCityLabel].forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
                backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                backView.heightAnchor.constraint(equalToConstant: 62),
                
                nameCityLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
                nameCityLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 16),
            ])
        
        nameCityLabel.text = city.name
        
    }

}
