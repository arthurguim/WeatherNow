//
//  SettingsTableViewController.swift
//  WeatherNow
//
//  Created by Arthur Silva on 16/01/20.
//  Copyright © 2020 Arthur Silva. All rights reserved.
//

import UIKit

class CitySelectionTableViewController: UITableViewController {

    var citysSelected: [String] = []

    // MARK: - Objects declaration
    let addCityCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = NSLocalizedString("Add_City_Text_Label_Cell", comment: "")
        cell.accessoryType = .disclosureIndicator
        return cell
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = NSLocalizedString("Navigation_Title", comment: "")

        view.addSubview(addCityCell)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if citysSelected.count == 0 {
            return 1
        } else {
            return 2
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if citysSelected.count == 0 || section == 1 {
            return 1
        } else {
            return citysSelected.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if citysSelected.count == 0 || indexPath.section == 1 {
            return addCityCell
        } else {
            let city = citysSelected[indexPath.row]
            let cell = UITableViewCell()
            cell.textLabel?.text = city
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if citysSelected.count != 0 && section == 0 {
            return NSLocalizedString("Group_TableView_Header_Title", comment: "")
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if citysSelected.count == 0 || section == 1 {
            return NSLocalizedString("Group_TableView_Footer_Title", comment: "")
        } else {
            return nil
        }
    }

    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
