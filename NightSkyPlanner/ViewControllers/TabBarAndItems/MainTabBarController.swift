//
//  ViewController.swift
//  NightSkyPlanner
//
//  Created by Vic on 22.01.2026.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: TabBar Items
    private let homeVC = UINavigationController(rootViewController: HomeViewController())
    private let notesVC = UINavigationController(rootViewController: NotesViewController())
    private let ROIsVC = UINavigationController(rootViewController: MapViewController())
    private let settingsVC = UINavigationController(rootViewController: SettingsViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarItems()
        configureNavigationControllers()
    }


}

extension MainTabBarController {
    func setupTabBarItems() {
        homeVC.tabBarItem = UITabBarItem(
            title: "Home", image: UIImage(systemName: "house.fill"), tag: 0
        )
        
        notesVC.tabBarItem = UITabBarItem(
            title: "Notes", image: UIImage(systemName: "list.clipboard.fill"), tag: 1
        )
        
        ROIsVC.tabBarItem = UITabBarItem(
            title: "Places", image: UIImage(systemName: "mappin.square.fill"), tag: 2
        )
        
        settingsVC.tabBarItem = UITabBarItem(
            title: "Settings", image: UIImage(systemName: "gearshape.fill"), tag: 3
        )
        
        viewControllers = [homeVC, notesVC, ROIsVC, settingsVC]
    }
    
    private func configureNavigationControllers() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        
        [homeVC, notesVC, ROIsVC, settingsVC].forEach { nav in
            nav.navigationBar.isTranslucent = false
            nav.navigationBar.standardAppearance = appearance
            nav.navigationBar.scrollEdgeAppearance = appearance
            nav.navigationBar.compactAppearance = appearance
        }
        
        homeVC.navigationBar.prefersLargeTitles = true
        notesVC.navigationBar.prefersLargeTitles = true
        ROIsVC.navigationBar.prefersLargeTitles = true
        settingsVC.navigationBar.prefersLargeTitles = false
    }
}
