//
//  CitySelectionTableViewController.swift
//  WeatherNow
//
//  Created by Arthur Silva on 22/01/20.
//  Copyright © 2020 Arthur Silva. All rights reserved.
//

import UIKit

class CitySelectionTableViewController: UITableViewController {

    // MARK: - Local paramethers
    var citysSelected: [String] = []

    var editButton: UIBarButtonItem {
        get {
            return UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(CitySelectionTableViewController.didTapEditingButton(sender:)))
        }
    }

    var doneButton: UIBarButtonItem {
        get {
            return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(CitySelectionTableViewController.didTapEditingButton(sender:)))
        }
    }

    // MARK: - Objects declaration
    let addCityButtonCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = NSLocalizedString("Add_City_Text_Label_Cell", comment: "")
        cell.accessoryType = .disclosureIndicator
        return cell
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = NSLocalizedString("Navigation_Title", comment: "")
        self.navigationItem.rightBarButtonItem = self.editButton
    }

    @objc func didTapEditingButton(sender: UIBarButtonItem) {
        UIView.animate(withDuration: 0.3) {
            self.tableView.isEditing.toggle()

            self.navigationItem.rightBarButtonItem = self.tableView.isEditing ? self.doneButton : self.editButton
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return citysSelected.count == 0 ? 1 : 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return citysSelected.count == 0 ? 1 : citysSelected.count
        case 1:
            return self.tableView.isEditing ? 0 : 1
        default:
            fatalError()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if self.citysSelected.count == 0 {
                return self.addCityButtonCell
            } else {
                let city = citysSelected[indexPath.row]
                let cell = UITableViewCell()
                cell.textLabel?.text = city
                return cell
            }
        case 1:
            return self.addCityButtonCell
        default:
            fatalError()
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
