//
//  CollectionViewCell.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var collection:Collection? {
        didSet {
            setupView()
        }
    }
    
    lazy var collectionName:UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.lineBreakMode = .byTruncatingMiddle
        l.numberOfLines = 3
        l.textColor = .white
        l.textAlignment = .center
        l.font = UIFont(name: SFOFont.proTextMedium.rawValue, size: 25)
        return l
    }()
    
    
    lazy var collectionDescription:UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.lineBreakMode = .byTruncatingMiddle
        l.numberOfLines = 4
        l.textColor = .white
        l.textAlignment = .center
        l.font = UIFont(name: SFOFont.proTextMedium.rawValue, size: 14)
        return l
    }()
    
    private lazy var thubmnail: UIImageView = {
        let f = UIImageView(frame: .zero)
        f.translatesAutoresizingMaskIntoConstraints = false
        f.contentMode = UIView.ContentMode.scaleAspectFill
        f.layer.masksToBounds = true
        return f
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.6
        return blurEffectView
    }()
    
    
    func setupView()  {
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        thubmnail.addToViewAndAddFullConstrainst(for: contentView)
        blurView.addToViewAndAddFullConstrainst(for: contentView)
        [collectionName, collectionDescription].forEach(contentView.addSubview)

        NSLayoutConstraint.activate([
            collectionName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionName.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionName.heightAnchor.constraint(equalToConstant: 70),
            
            collectionDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            collectionDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            collectionDescription.topAnchor.constraint(equalTo: collectionName.bottomAnchor),
            collectionDescription.heightAnchor.constraint(equalToConstant: 80)
            
            
            ])
        
        guard let collection = collection else {
            return
        }
        
        if let url = URL(string: collection.image_url) {
            thubmnail.setImageWithURL(url: url)
        }
        
        collectionName.text = collection.title
        collectionDescription.text = collection.description
    }
}
