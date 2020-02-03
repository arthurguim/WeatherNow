//
//  NewCityCollectionViewCell.swift
//  WeatherNow
//
//  Created by Arthur Silva on 29/01/20.
//  Copyright © 2020 Arthur Silva. All rights reserved.
//

import UIKit

class NewCityCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var addNewCityLabel: UILabel!

    static let viewIdentifier: String = "NewCityCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()

        self.addNewCityLabel.text = NSLocalizedString("Add_New_City_Button", comment: "")
    }

}
