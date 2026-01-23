//
//  SettingsViewController.swift
//  NightSkyPlanner
//
//  Created by Vic on 22.01.2026.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: menu sections
    private var sections = [
        Section(title: "General", rows: [
            Row(title: "Location", style: .rowWithSubtitle, value: nil),
            Row(title: "Night mode", style: .switchToggle, value: false),
            Row(title: "Notifications", style: .switchToggle, value: false)
        ]),
        Section(title: "About", rows: [
            Row(title: "Purpose", style: .disclosure, value: nil),
            Row(title: "About Author", style: .disclosure, value: nil),
            Row(title: "Buy me a ☕️", style: .button, value: nil),
            Row(title: "Created by Vic Sergeev", style: .rowValue, value: nil)
        ])
    ]

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        navigationItem.largeTitleDisplayMode = .never
        
        setupTableView()
    }
    
    // MARK: UITableView settings
    private func setupTableView() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
    }

    
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    // MARK: Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        
        switch row.style {
        case .switchToggle:
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = row.title
            
            let toggle = UISwitch()
            toggle.isOn = (row.value as? Bool) ?? false
            toggle.tag = indexPath.section * 1000 + indexPath.row // unique ID for each switch
            // e.g. night mode 0 * 1000 + 1 = 1 or notification 0 * 1000 + 2(indexPath.row) = 2
            toggle.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
            // save indexPath in property to keep track of what exactly changed
            
            cell.accessoryView = toggle
            return cell
            
        case .disclosure:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell.textLabel?.text = row.title
            cell.accessoryType = .disclosureIndicator
            return cell
            
        case .button:
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = row.title
            cell.textLabel?.textColor = .systemOrange
            return cell
            
        case .rowValue:
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            // since textLabel will be depricated in future version of UIKit use UIListContentConfiguration
            
            // create config
            var content = cell.defaultContentConfiguration()
            content.text = row.title
            content.textProperties.color = .green
            
            cell.contentConfiguration = content
            cell.selectionStyle = .none
            
            return cell
            
            // row with subtitle
        case .rowWithSubtitle:
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            
            // config
            var content = cell.defaultContentConfiguration()
            
            // main text
            content.text = row.title
            content.textProperties.font = .systemFont(ofSize: 20, weight: .regular)
            
            // secondary text
            content.secondaryText = "Location not set"
            content.secondaryTextProperties.font = .systemFont(ofSize: 14)
            content.secondaryTextProperties.color = .systemGray
            content.secondaryTextProperties.numberOfLines = 0 // multiline row
            
            // vertical margins
            content.directionalLayoutMargins = NSDirectionalEdgeInsets(
                top: 14, leading: 16, bottom: 14, trailing: 16
            )
            
            // implement settings
            cell.contentConfiguration = content
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .default
            
            return cell
        }
        
    }
    
    // MARK: Actions
    @objc private func switchToggled(_ sender: UISwitch) {
        // decode indexPath from tag
        let section = sender.tag / 1000 // number of section
        let row = sender.tag % 1000 // number of row
        // therefore we know that changed switch of specific section/row
        
        // update value in model
        if section < sections.count && row < sections[section].rows.count {
            sections[section].rows[row].value = sender.isOn
        }
    }

    
    // MARK: Transitions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // release selection of row
        tableView.deselectRow(at: indexPath, animated: true)
        
        // get specific row
        let row = sections[indexPath.section].rows[indexPath.row]
        
        switch row.style {
        case .rowWithSubtitle:
            // create vc for specific cell
//            let locationVC = LocationViewController()
//            locationVC.title = "Select Location"
//
//            // transition to location screen
//            navigationController?.pushViewController(locationVC, animated: true)
            
            let vc = UIViewController() as? LocationViewController
            vc?.view.backgroundColor = .systemRed
            vc?.title = "TEST"
            navigationController?.pushViewController(vc ?? UIViewController(), animated: true)

            
        case .disclosure:
            if row.title == "Purpose" {
                let purposeVC = PurposeViewController()
                purposeVC.navigationItem.largeTitleDisplayMode = .never
                navigationController?.pushViewController(purposeVC, animated: true)
            } else if row.title == "About Author" {
                let aboutVC = AboutViewController()
                aboutVC.navigationItem.largeTitleDisplayMode = .never
                navigationController?.pushViewController(aboutVC, animated: true)
            }
            
            
        case .button:
            let coffeeVC = CoffeeViewController()
            navigationController?.pushViewController(coffeeVC, animated: true)
        case .rowValue:
            print("nothing here")
        default:
            print("wrong vc")
            break
        }
    }
}
