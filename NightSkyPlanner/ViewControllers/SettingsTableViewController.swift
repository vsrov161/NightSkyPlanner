//
//  SettingsTableViewController.swift
//  NightSkyPlanner
//
//  Created by Vic on 22.01.2026.
//

import UIKit

final class SettingsTableViewController: UITableViewController {
    
    // MARK: menu sections
    private var sections = [
        Section(title: "General", rows: [
            Row(title: "Location", style: .disclosure, value: nil),
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

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
            content.textProperties.color = .blue
            
            cell.contentConfiguration = content
            
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

}
