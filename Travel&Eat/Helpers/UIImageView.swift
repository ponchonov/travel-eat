//
//  UIImageView.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func setImageWithURL(url:URL) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
        } else {
            let indicator = UIActivityIndicatorView(style: .gray)
            DispatchQueue.main.async {
                indicator.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(indicator)
                indicator.hidesWhenStopped = true
                NSLayoutConstraint.activate([
                    indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                    indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                    ])
                
            }
            DispatchQueue.global(qos: .background).async {
                do {
                    
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data) {
                            imageCache.setObject(image, forKey: url.absoluteString as NSString)
                            self.image = image
                        }
                        indicator.stopAnimating()
                    }
                } catch (let e) {
                    print(e)
                    DispatchQueue.main.async {
                        indicator.stopAnimating()
                    }
                }
            }
        }
    }
    
}

