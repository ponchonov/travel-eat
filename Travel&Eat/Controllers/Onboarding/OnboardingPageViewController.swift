//
//  OnboardingPageViewController.swift
//  Travel&Eat
//
//  Created by Héctor Cuevas on 21/08/19.
//  Copyright © 2019 Héctor Cuevas. All rights reserved.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    
    lazy var skipButton: UIButton = {
        let b = UIButton (frame: .zero)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Skip", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = UIFont(name: SFOFont.proTextRegular.rawValue, size: 17)
        b.alpha = 0.35
        b.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        return b
    }()
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    
    
    @objc func skipTapped() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        DispatchQueue.main.async {
            delegate.window?.rootViewController = ViewController()
            delegate.window?.makeKeyAndVisible()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        // Do any additional setup after loading the view.
    }
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
        self.dataSource = self
        self.delegate = self
        setupView()
    }
    
    // Pages and page control configuration
    func setupView()   {
        let initialPage = 0
        let page1 = OnboardingViewController( index: 0)
        let page2 = OnboardingViewController( index: 1)
        let page3 = OnboardingViewController( index: 2)
        
        view.backgroundColor = .white
        // add the individual viewControllers to the pageViewController
        self.pages.append(page1)
        self.pages.append(page2)
        self.pages.append(page3)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        // pageControl
        self.pageControl.frame = CGRect()
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.currentPageIndicatorTintColor = .white
        self.pageControl.pageIndicatorTintColor = .lightGray
        self.pageControl.numberOfPages = self.pages.count
        self.pageControl.currentPage = initialPage
        
        self.view.addSubview(self.pageControl)
        
        self.view.addSubview(skipButton)
        NSLayoutConstraint.activate([
            self.pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            self.pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20),
            self.pageControl.heightAnchor.constraint(equalToConstant: 20),
            self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension OnboardingPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                // wrap to last page in array
                return nil
            } else {
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                print(viewControllerIndex)
                return self.pages[viewControllerIndex + 1]
            } else {
                return nil
            }
        }
        return nil
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
                if viewControllerIndex == 2 {
                    skipButton.setTitle("Continue", for: .normal)
                    skipButton.alpha = 1
                    skipButton.titleLabel?.font = UIFont(name: SFOFont.proTextBold.rawValue, size: 20)
                } else {
                    skipButton.setTitle("Skip", for: .normal)
                    skipButton.alpha = 0.35
                    skipButton.titleLabel?.font = UIFont(name: SFOFont.proTextRegular.rawValue, size: 17)

                }
            }
        }
    }
    
}
