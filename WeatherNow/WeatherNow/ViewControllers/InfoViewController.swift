//
//  InfoViewController.swift
//  WeatherNow
//
//  Created by Arthur Silva on 21/01/20.
//  Copyright © 2020 Arthur Silva. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var infoTextView: UITextView!

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Local functions
    func setupView() {
        let attributedString = NSMutableAttributedString(string: NSLocalizedString("Info_Text", comment: ""), attributes: [
            .foregroundColor: traitCollection.userInterfaceStyle == .light ? UIColor.black : UIColor.white
        ])
        attributedString.addAttribute(.link, value: InfoConstants.openWeatherMapUrl, range: NSRange(location: 32, length: 11))
        attributedString.addAttribute(.link, value: InfoConstants.freepikUrl, range: NSRange(location: 59, length: 7))
        attributedString.addAttribute(.link, value: InfoConstants.flatIconUrl, range: NSRange(location: 72, length: 16))
        self.infoTextView.attributedText = attributedString
    }

}
