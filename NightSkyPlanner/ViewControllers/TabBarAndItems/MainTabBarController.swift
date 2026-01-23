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
    private let notesVC = UINavigationController(rootViewController: NotesTableViewController())
    private let ROIsVC = UINavigationController(rootViewController: ROIViewController())
    private let settingsVC = UINavigationController(rootViewController: SettingsTableViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarItems()
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
            title: "ROIs", image: UIImage(systemName: "mappin.square.fill"), tag: 2
        )
        
        settingsVC.tabBarItem = UITabBarItem(
            title: "Settings", image: UIImage(systemName: "gearshape.fill"), tag: 3
        )
        
        viewControllers = [homeVC, notesVC, ROIsVC, settingsVC]
    }
}
