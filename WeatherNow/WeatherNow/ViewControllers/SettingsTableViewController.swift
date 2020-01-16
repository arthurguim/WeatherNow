//
//  SettingsTableViewController.swift
//  WeatherNow
//
//  Created by Arthur Silva on 16/01/20.
//  Copyright © 2020 Arthur Silva. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    // MARK: - Objects declaration
    let temperatureCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Unit"
        return cell
    }()

    let temperatureUnitSegControll: UISegmentedControl = {
        let items: [String] = ["°C", "°F"]
        let segControll = UISegmentedControl(items: items)
        segControll.translatesAutoresizingMaskIntoConstraints = false
        return segControll
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Settings"
        tableView.allowsSelection = false

        view.addSubview(temperatureCell)

        setupLayout()
    }

    func setupLayout() {
        temperatureCell.addSubview(temperatureUnitSegControll)
        temperatureUnitSegControll.trailingAnchor.constraint(equalTo: temperatureCell.trailingAnchor, constant: -10).isActive = true
        temperatureUnitSegControll.centerYAnchor.constraint(equalTo: temperatureCell.centerYAnchor).isActive = true
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return temperatureCell
            default:
                fatalError()
            }
        default:
            fatalError()
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Temperature"
        default:
            fatalError()
        }
    }

}
