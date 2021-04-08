//
//  OnboardingViewController.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
    }
    
    let index:Int
    
    lazy var backGroundImage: UIImageView = {
        let i = UIImageView(frame: .zero)
        switch self.index {
        case 0:
            i.image = UIImage(named: "onboarding1")
        case 1:
            i.image = UIImage(named: "onboarding2")
        case 2:
            i.image = UIImage(named: "onboarding3")
        default:
            break
        }
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    lazy var titleText:UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.textAlignment = .center
        l.font = UIFont(name: SFOFont.proTextBold.rawValue, size: 22)
        l.contentHuggingPriority(for: .horizontal)
        l.numberOfLines = 0

        return l
    }()
    
    lazy var contentText:UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.textAlignment = .center
        l.font = UIFont(name: SFOFont.proTextRegular.rawValue, size: 17)
        l.numberOfLines = 0
        return l
    }()
    
    init(index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
        setUpView()
    }
    
    
    func setUpView()  {
        
        [backGroundImage, titleText, contentText].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            backGroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            backGroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleText.bottomAnchor.constraint(equalTo: contentText.topAnchor, constant: -15),
            titleText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            contentText.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -70),
            contentText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ])
        
        switch index {
        case 0:
            titleText.text = "Welcome to\nTravel and Eat"
            contentText.text = "Found restaurants nearby your location\nor plan where to eat in your\nnext Travel."
        case 1:
            titleText.text = "Search and Save"
            contentText.text = "Search  the restaurants for your next\ntravel and save theirs location"
        case 2:
            titleText.text = "Choose"
            contentText.text = "Compare between  rating and distance"
            
        default:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
