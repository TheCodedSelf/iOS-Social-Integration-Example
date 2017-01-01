//
//  LinkedInProfileViewController.swift
//  SocialIntegrationPOC
//
//  Created by Keegan Rush on 2016/12/31.
//  Copyright © 2016 Shnapped. All rights reserved.
//

import UIKit

class LinkedInProfileViewController: UIViewController {
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var profileUrlLabel: UILabel!
    
    override func viewDidLoad() {
        LinkedInConnector.sharedInstance.getUserData() { (user) in
            if let user = user {
                DispatchQueue.main.async { [weak self] in
                    self?.populateFields(with: user)
                }
            }
        }
    }
    
    private func populateFields(with user: LinkedInUser) {
        firstNameLabel.text = user.firstName
        lastNameLabel.text = user.lastName
        headlineLabel.text = user.headline
        profileUrlLabel.text = user.profileUrl
    }
}
