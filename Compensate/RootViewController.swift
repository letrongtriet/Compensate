//
//  RootViewController.swift
//  Compensate
//
//  Created on 23.5.2020.
//  Copyright © 2020 Compensate. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {
    
    // MARK: - Dependencies
    
    
    // MARK: - Private properties
    private lazy var hotViewController: PostsViewController = {
        let vc = PostsViewController()
        let viewModel = PostsViewModel(section: .Hot)
        vc.viewModel = viewModel
        return vc
    }()
    
    private lazy var topViewController: PostsViewController = {
        let vc = PostsViewController()
        let viewModel = PostsViewModel(section: .Top)
        vc.viewModel = viewModel
        return vc
    }()
    
    private lazy var newViewController: PostsViewController = {
        let vc = PostsViewController()
        let viewModel = PostsViewModel(section: .New)
        vc.viewModel = viewModel
        return vc
    }()
    

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        tabBar.tintColor = UIColor.black
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.white
        tabBar.shadowImage = UIImage()
        
        var controllers: [UIViewController] = []
        
        hotViewController.tabBarItem = UITabBarItem(title: "Hot", image: UIImage(named: "hot"), selectedImage: nil)
        controllers.append(hotViewController)
        
        topViewController.tabBarItem = UITabBarItem(title: "Top", image: UIImage(named: "top"), selectedImage: nil)
        controllers.append(topViewController)
        
        newViewController.tabBarItem = UITabBarItem(title: "New", image: UIImage(named: "new"), selectedImage: nil)
        controllers.append(newViewController)
        
        setViewControllers(controllers, animated: false)
    }

}
